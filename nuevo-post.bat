@echo off
setlocal
cd /d "%~dp0"

echo ==============================================
echo   NUEVO POST - MODO FACIL
echo ==============================================
echo.

powershell -NoProfile -ExecutionPolicy Bypass -File ".\nuevo-post.ps1"

if errorlevel 1 (
  echo.
  echo [ERROR] No se pudo crear el post.
  pause
  exit /b 1
)

echo.
echo [OK] Post creado y abierto para editar.
pause
exit /b 0
