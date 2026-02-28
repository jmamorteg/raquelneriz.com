# Troubleshooting técnico (estado actual del proyecto)

Guía para incidencias en entorno Windows con:

- Ruby `3.1` (`C:\Ruby31-x64`)
- Bundler `2.6.9`
- Jekyll + GitHub Pages + `remote_theme`
- Certificados corporativos (`.certs/ruby31-ca-bundle.pem`)
- Sitio multidioma (`/ca`, `/es`, `/en`) con fallback catalán

---

## 1) Diagnóstico rápido

Ejecutar en PowerShell desde la raíz del repo:

```powershell
$env:HOME='C:\Users\JUANMA~1.AMO\AppData\Local\Temp'
$env:PATH='C:\Ruby31-x64\bin;' + $env:PATH
$env:SSL_CERT_FILE=(Resolve-Path './.certs/ruby31-ca-bundle.pem').Path
$env:BUNDLE_SSL_CA_CERT=$env:SSL_CERT_FILE

ruby -v
bundle -v
bundle _2.6.9_ exec jekyll build
```

Si este bloque falla, no intentar `serve` hasta resolverlo.

---

## 2) `bundle` o `ruby` no encontrados

### Síntoma

- `'bundle' is not recognized` o `'ruby' is not recognized`

### Causa habitual

- Ruby no instalado o PATH no cargado en la sesión actual.

### Solución

1. Ejecutar setup:

```powershell
powershell -ExecutionPolicy Bypass -File .\setup.ps1
```

2. Si Ruby está instalado pero no entra en PATH, forzar en sesión:

```powershell
$env:PATH='C:\Ruby31-x64\bin;' + $env:PATH
```

---

## 3) Errores SSL (`certificate verify failed`, `self-signed certificate in chain`)

### Síntoma

- Fallo en `bundle install`, `jekyll build` o `jekyll serve` al descargar gems/tema remoto.

### Causa habitual

- Interceptación SSL corporativa sin CA combinada en Ruby/Bundler.

### Solución

1. Verificar bundle CA:

```powershell
Test-Path .\.certs\ruby31-ca-bundle.pem
```

2. Si no existe o está desactualizado, regenerar con setup:

```powershell
powershell -ExecutionPolicy Bypass -File .\setup.ps1 -SkipRubyInstall
```

3. Exportar variables antes de build/serve:

```powershell
$env:SSL_CERT_FILE=(Resolve-Path './.certs/ruby31-ca-bundle.pem').Path
$env:BUNDLE_SSL_CA_CERT=$env:SSL_CERT_FILE
```

---

## 4) `Serve Jekyll Site` falla en VS Code (exit code 1)

### Diagnóstico

1. Ver output de tarea:

- Terminal/Task output de `Serve Jekyll Site`

2. Ejecutar manualmente con variables explícitas:

```powershell
$env:HOME='C:\Users\JUANMA~1.AMO\AppData\Local\Temp'
$env:PATH='C:\Ruby31-x64\bin;' + $env:PATH
$env:SSL_CERT_FILE=(Resolve-Path './.certs/ruby31-ca-bundle.pem').Path
$env:BUNDLE_SSL_CA_CERT=$env:SSL_CERT_FILE
bundle _2.6.9_ exec jekyll serve --livereload
```

### Causas típicas

- SSL corporativo (ver sección 3).
- Puerto ocupado (`4000` o `35729`).
- Gem lock/desfase de Bundler.

### Fix rápido de puertos

```powershell
Get-NetTCPConnection -LocalPort 4000,35729 -ErrorAction SilentlyContinue | Select-Object LocalPort,OwningProcess,State
```

Si hay proceso bloqueando, cerrarlo y relanzar `serve`.

---

## 5) `bundle install` / `jekyll build` falla por lockfile o gems

### Síntoma

- Errores de versión de Bundler o gems no instaladas.

### Solución

```powershell
$env:HOME='C:\Users\JUANMA~1.AMO\AppData\Local\Temp'
$env:PATH='C:\Ruby31-x64\bin;' + $env:PATH
$env:SSL_CERT_FILE=(Resolve-Path './.certs/ruby31-ca-bundle.pem').Path
$env:BUNDLE_SSL_CA_CERT=$env:SSL_CERT_FILE

gem install bundler -v 2.6.9 --no-document
bundle _2.6.9_ config set --local path 'vendor/bundle'
bundle _2.6.9_ install
bundle _2.6.9_ exec jekyll build
```

---

## 6) Cambios no se ven en producción

### Checklist

1. Confirmar push al branch correcto (`main`).
2. Esperar 1-3 minutos.
3. Revisar estado de Pages en GitHub.
4. Forzar refresh de navegador (`Ctrl + F5`).
5. Verificar que no se editó `_site/` en vez de fuentes reales.

---

## 7) Problemas de rutas multidioma

### Síntomas

- Menú lleva a 404.
- Selector de idioma no mantiene sección equivalente.
- Solo un idioma refleja cambios.

### Puntos de control

- Navegación por idioma:
	- `_data/navigation_ca.yml`
	- `_data/navigation_es.yml`
	- `_data/navigation_en.yml`
- Selector:
	- `_includes/lang-switcher.html`
- Redirección raíz:
	- `index.html`

### Validación rápida tras build

```powershell
$env:HOME='C:\Users\JUANMA~1.AMO\AppData\Local\Temp'
$env:PATH='C:\Ruby31-x64\bin;' + $env:PATH
$env:SSL_CERT_FILE=(Resolve-Path './.certs/ruby31-ca-bundle.pem').Path
$env:BUNDLE_SSL_CA_CERT=$env:SSL_CERT_FILE
bundle _2.6.9_ exec jekyll build

@(Test-Path .\_site\ca\index.html),
@(Test-Path .\_site\es\index.html),
@(Test-Path .\_site\en\index.html)
```

---

## 8) Portfolio no muestra items o imágenes

### Síntomas

- Sección vacía aunque se añadió item.
- Imagen rota en tarjeta.

### Puntos de control

1. Data source:
	 - `_data/portfolio.json`
2. Imagen física:
	 - `assets/img/portfolio/...`
3. Ruta `image` en JSON debe empezar por `/assets/img/portfolio/...`
4. Verificar formato JSON válido (comas/llaves).

---

## 9) Estilos no aplican / UI rota

### Puntos de control

1. Archivo principal de estilos:
	 - `assets/css/style.scss`
2. Debe mantener front matter al inicio:

```scss
---
---
```

3. No crear `assets/css/style.css` manualmente (evitar conflicto).
4. Verificar inclusión en layout base (`_layouts/default.html`).

---

## 10) Recuperación estándar (runbook)

Cuando el entorno queda inestable:

```powershell
# 1) Re-setup controlado
powershell -ExecutionPolicy Bypass -File .\setup.ps1 -SkipRubyInstall

# 2) Build limpio
$env:HOME='C:\Users\JUANMA~1.AMO\AppData\Local\Temp'
$env:PATH='C:\Ruby31-x64\bin;' + $env:PATH
$env:SSL_CERT_FILE=(Resolve-Path './.certs/ruby31-ca-bundle.pem').Path
$env:BUNDLE_SSL_CA_CERT=$env:SSL_CERT_FILE
bundle _2.6.9_ exec jekyll build

# 3) Serve
bundle _2.6.9_ exec jekyll serve --livereload
```

Si build funciona y serve falla, capturar error exacto y diagnosticar por secciones 3-5.

---

## 11) Referencias de configuración

- Task VS Code: `.vscode/tasks.json`
- Setup automatizado: `setup.ps1` y `setup.bat`
- Checklist operativo simplificado: `README.md` y `BOTONES/LEEME-PRIMERO.txt`
