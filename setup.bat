@echo off
setlocal
cd /d "%~dp0"

echo [INFO] Ejecutando setup de entorno para este proyecto...
powershell -NoProfile -ExecutionPolicy Bypass -File ".\setup.ps1"

if errorlevel 1 (
  echo.
  echo [ERROR] El setup no se completo correctamente.
  pause
  exit /b 1
)

echo.
echo [OK] Setup completado.
pause
exit /b 0
