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

    if ([string]::IsNullOrWhiteSpace($ascii)) {
        return 'nuevo-post'
    }

    return $ascii
}

$repoRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$postsDir = Join-Path $repoRoot '_posts'

if (-not (Test-Path $postsDir)) {
    New-Item -ItemType Directory -Path $postsDir -Force | Out-Null
}

if ([string]::IsNullOrWhiteSpace($Title)) {
    $Title = Read-Host 'Escribe el titulo del nuevo post'
}

if ([string]::IsNullOrWhiteSpace($Title)) {
    Write-Host 'No se ha indicado titulo. Operacion cancelada.' -ForegroundColor Yellow
    exit 1
}

$now = Get-Date
$datePart = $now.ToString('yyyy-MM-dd')
$timePart = $now.ToString('yyyy-MM-dd HH:mm:ss')
$tzOffset = $now.ToString('zzz').Replace(':', '')
$slug = Convert-ToSlug -Text $Title
$fileName = "$datePart-$slug.markdown"
$postPath = Join-Path $postsDir $fileName

if (Test-Path $postPath) {
    $postPath = Join-Path $postsDir ("{0}-{1}.markdown" -f $datePart, ($slug + '-' + $now.ToString('HHmm')))
}

$content = @"
---
layout: post
title: "$Title"
date: $timePart $tzOffset
categories: [reflexiones]
tags: [blog]
---

Escribe aqui tu post.

## Idea principal

Desarrolla el tema con naturalidad.

## Cierre

Puedes terminar con una pregunta o reflexion final.
"@

Set-Content -Path $postPath -Value $content -Encoding UTF8

Write-Host "Post creado: $postPath" -ForegroundColor Green
Write-Host 'Se abrira en el Bloc de notas para editarlo.' -ForegroundColor Cyan
Start-Process notepad.exe $postPath
