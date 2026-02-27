@echo off
setlocal
cd /d "%~dp0"

echo ==============================================
echo   PUBLICAR POSTS - MODO FACIL
echo ==============================================
echo.

where git >nul 2>nul
if errorlevel 1 (
  echo [ERROR] Git no esta instalado o no esta en PATH.
  pause
  exit /b 1
)

echo Se van a publicar los cambios en _posts
set /p MENSAJE=Escribe un mensaje corto (o pulsa Enter para usar uno automatico): 

if "%MENSAJE%"=="" set MENSAJE=Nuevos posts %date% %time%

git add _posts
git commit -m "%MENSAJE%"

if errorlevel 1 (
  echo.
  echo [INFO] Puede que no haya cambios nuevos para publicar.
  pause
  exit /b 0
)

git push origin main

if errorlevel 1 (
  echo.
  echo [ERROR] No se pudo hacer push. Revisa tu sesion de GitHub.
  pause
  exit /b 1
)

echo.
echo [OK] Publicado correctamente. GitHub Pages tardara 1-3 minutos.
echo.
echo Enlaces para revisar:
echo - Web:  https://www.raquelneriz.com/
echo - Blog: https://www.raquelneriz.com/blog/
echo.
echo Abriendo blog en el navegador...
start "" "https://www.raquelneriz.com/blog/"
pause
exit /b 0
