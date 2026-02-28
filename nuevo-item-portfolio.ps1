param(
    [string]$Title
)

$ErrorActionPreference = 'Stop'

function Convert-ToSlug {
    param([string]$Text)

    $normalized = $Text.Normalize([Text.NormalizationForm]::FormD)
    $builder = New-Object System.Text.StringBuilder
    foreach ($char in $normalized.ToCharArray()) {
        $category = [Globalization.CharUnicodeInfo]::GetUnicodeCategory($char)
        if ($category -ne [Globalization.UnicodeCategory]::NonSpacingMark) {
            [void]$builder.Append($char)
        }
    }

    $ascii = $builder.ToString().Normalize([Text.NormalizationForm]::FormC).ToLowerInvariant()
    $ascii = $ascii -replace '[^a-z0-9]+', '-'
    $ascii = $ascii.Trim('-')
    if ([string]::IsNullOrWhiteSpace($ascii)) { return 'item' }
    return $ascii
}

$repoRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$dataPath = Join-Path $repoRoot '_data/portfolio.json'
$imagesDir = Join-Path $repoRoot 'assets/img/portfolio'

if (-not (Test-Path $imagesDir)) {
    New-Item -ItemType Directory -Path $imagesDir -Force | Out-Null
}

if ([string]::IsNullOrWhiteSpace($Title)) {
    $Title = Read-Host 'Título de la imagen/proyecto'
}
if ([string]::IsNullOrWhiteSpace($Title)) {
    Write-Host 'Sin título. Cancelado.' -ForegroundColor Yellow
    exit 1
}

Write-Host 'Sección destino:' -ForegroundColor Cyan
Write-Host '1) restauracion  2) kintsugi  3) mis-obras  4) tatuaje'
$sectionInput = Read-Host 'Elige número (1-4)'
$sectionMap = @{ '1' = 'restauracion'; '2' = 'kintsugi'; '3' = 'mis-obras'; '4' = 'tatuaje' }
$sectionId = $sectionMap[$sectionInput]
if (-not $sectionId) {
    Write-Host 'Sección no válida. Cancelado.' -ForegroundColor Yellow
    exit 1
}

$sourceImage = Read-Host 'Ruta completa de la imagen (jpg/png/webp)'
if (-not (Test-Path $sourceImage)) {
    Write-Host 'No se encontró la imagen.' -ForegroundColor Yellow
    exit 1
}

$description = Read-Host 'Descripción breve (opcional)'
$hashtags = Read-Host 'Hashtags (ejemplo: #kintsugi #restauracion) - opcional'
$link = Read-Host 'Link externo (opcional)'

$slug = Convert-ToSlug -Text $Title
$extension = [IO.Path]::GetExtension($sourceImage)
$fileName = "{0}-{1}{2}" -f (Get-Date -Format 'yyyyMMdd-HHmmss'), $slug, $extension
$destImage = Join-Path $imagesDir $fileName
Copy-Item $sourceImage $destImage -Force

$relativeImage = "/assets/img/portfolio/$fileName"
$raw = Get-Content $dataPath -Raw
$data = $raw | ConvertFrom-Json -Depth 20

$targetSection = $data.sections | Where-Object { $_.id -eq $sectionId } | Select-Object -First 1
if (-not $targetSection) {
    Write-Host 'No se encontró la sección destino en portfolio.json' -ForegroundColor Red
    exit 1
}

$newItem = [PSCustomObject]@{
    title = $Title
    image = $relativeImage
    description = $description
    hashtags = $hashtags
    link = $link
}

$updatedItems = @()
if ($targetSection.items) {
    $updatedItems += @($targetSection.items)
}
$updatedItems += $newItem
$targetSection.items = $updatedItems

$data | ConvertTo-Json -Depth 20 | Set-Content -Path $dataPath -Encoding UTF8

Write-Host "Imagen añadida al portfolio en sección '$sectionId'." -ForegroundColor Green
Write-Host "Archivo copiado: $destImage" -ForegroundColor Cyan
