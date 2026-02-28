@echo off
setlocal
cd /d "%~dp0"

echo ==============================================
echo   NUEVO ITEM DE PORTFOLIO - MODO FACIL
echo ==============================================
echo.

powershell -NoProfile -ExecutionPolicy Bypass -File ".\nuevo-item-portfolio.ps1"

if errorlevel 1 (
  echo.
  echo [ERROR] No se pudo crear el item de portfolio.
  pause
  exit /b 1
)

echo.
echo [OK] Item añadido. Ahora puedes revisar /portfolio y publicar cambios.
pause
exit /b 0
