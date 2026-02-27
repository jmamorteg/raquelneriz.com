param(
    [switch]$SkipRubyInstall,
    [switch]$SkipBundleInstall,
    [switch]$StartServer
)

$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest

$repoRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$rubyRoot = 'C:\Ruby31-x64'
$rubyExe = Join-Path $rubyRoot 'bin\ruby.exe'
$gemExe = Join-Path $rubyRoot 'bin\gem.cmd'
$bundleExe = Join-Path $rubyRoot 'bin\bundle.bat'
$certsDir = Join-Path $repoRoot '.certs'
$bundleCertPath = Join-Path $certsDir 'ruby31-ca-bundle.pem'
$netskopeCertPath = Join-Path $certsDir 'netskope-ca.pem'

function Write-Step {
    param([string]$Message)
    Write-Host "`n==> $Message" -ForegroundColor Cyan
}

function Ensure-Ruby31 {
    if (Test-Path $rubyExe) {
        Write-Host "Ruby 3.1 ya está instalado en $rubyRoot" -ForegroundColor Green
        return
    }

    if ($SkipRubyInstall) {
        throw "No se encontró Ruby 3.1 en $rubyRoot y se indicó -SkipRubyInstall."
    }

    Write-Step 'Instalando Ruby 3.1 con DevKit vía winget'
    if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
        throw 'winget no está disponible en este equipo. Instala Ruby manualmente y vuelve a ejecutar setup.ps1.'
    }

    winget install --id RubyInstallerTeam.RubyWithDevKit.3.1 --silent --accept-package-agreements --accept-source-agreements | Out-Host

    if (-not (Test-Path $rubyExe)) {
        throw "La instalación terminó, pero no se encontró $rubyExe."
    }
}

function New-CombinedCaBundle {
    Write-Step 'Preparando certificado CA para entorno corporativo'

    New-Item -ItemType Directory -Path $certsDir -Force | Out-Null

    $rubyDefaultCa = Join-Path $rubyRoot 'ssl\cert.pem'
    if (-not (Test-Path $rubyDefaultCa)) {
        throw "No se encontró el bundle de certificados de Ruby en $rubyDefaultCa"
    }

    $netskopeCert = Get-ChildItem Cert:\CurrentUser\Root,Cert:\LocalMachine\Root |
        Where-Object { $_.Subject -match 'caadmin\.netskope\.com|Netskope' -or $_.Issuer -match 'caadmin\.netskope\.com|Netskope' } |
        Select-Object -First 1

    if ($null -ne $netskopeCert) {
        $pemBody = [Convert]::ToBase64String($netskopeCert.RawData, [Base64FormattingOptions]::InsertLineBreaks)
        $pemText = "-----BEGIN CERTIFICATE-----`n$pemBody`n-----END CERTIFICATE-----`n"
        Set-Content -Path $netskopeCertPath -Value $pemText -NoNewline
        Get-Content $rubyDefaultCa, $netskopeCertPath | Set-Content $bundleCertPath
        Write-Host "CA combinada creada en $bundleCertPath" -ForegroundColor Green
    }
    else {
        Copy-Item $rubyDefaultCa $bundleCertPath -Force
        Write-Host 'No se encontró certificado Netskope. Se usará solo CA de Ruby.' -ForegroundColor Yellow
    }
}

function Set-RubyEnvironment {
    $env:PATH = "$rubyRoot\bin;$env:PATH"
    $env:HOME = $env:TEMP
    $env:SSL_CERT_FILE = $bundleCertPath
    $env:BUNDLE_SSL_CA_CERT = $bundleCertPath
}

Push-Location $repoRoot
try {
    Write-Step 'Verificando Ruby'
    Ensure-Ruby31

    Write-Step 'Generando bundle de certificados'
    New-CombinedCaBundle

    Write-Step 'Configurando variables de entorno de Ruby/Bundler'
    Set-RubyEnvironment

    Write-Step 'Verificando versiones'
    & $rubyExe -v | Out-Host
    & $gemExe -v | Out-Host

    if (-not $SkipBundleInstall) {
        Write-Step 'Instalando Bundler 2.6.9'
        & $gemExe install bundler -v 2.6.9 --no-document | Out-Host

        Write-Step 'Instalando gems del proyecto en vendor/bundle'
        & $bundleExe _2.6.9_ config set --local path 'vendor/bundle' | Out-Host
        & $bundleExe _2.6.9_ install | Out-Host
    }

    Write-Step 'Validando compilación de Jekyll'
    & $bundleExe _2.6.9_ exec jekyll build | Out-Host

    if ($StartServer) {
        Write-Step 'Iniciando servidor local con LiveReload'
        & $bundleExe _2.6.9_ exec jekyll serve --livereload
    }

    Write-Host "`nSetup completado. Puedes ejecutar el task 'Serve Jekyll Site' en VS Code." -ForegroundColor Green
}
finally {
    Pop-Location
}
