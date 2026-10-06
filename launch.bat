@echo off
chcp 65001 >nul
title Elect27 - Lancement

echo.
echo  ╔═══════════════════════════════════════════════════════════╗
echo  ║                                                           ║
echo  ║       ELECT27 - Lieux de Vote Congo 2027                  ║
echo  ║       Application de Localisation                         ║
echo  ║                                                           ║
echo  ╚═══════════════════════════════════════════════════════════╝
echo.

:menu
echo  Selectionnez le mode de lancement :
echo.
echo    [1] Docker (Recommande)
echo    [2] Developpement Local (Python)
echo    [3] Ouvrir le navigateur
echo    [4] Arreter Docker
echo    [5] Quitter
echo.
set /p choice="  Votre choix : "

if "%choice%"=="1" goto docker
if "%choice%"=="2" goto local
if "%choice%"=="3" goto browser
if "%choice%"=="4" goto stop
if "%choice%"=="5" goto end

echo  Choix invalide !
timeout /t 2 >nul
cls
goto menu

:docker
echo.
echo  Lancement avec Docker Compose...
echo.
docker-compose up -d
if errorlevel 1 (
    echo.
    echo  [ERREUR] Docker n'est pas en cours d'execution !
    echo  Veuillez demarrer Docker Desktop.
    echo.
    pause
    goto menu
)
echo.
echo  Demarrage en cours... Attendez 10 secondes.
timeout /t 10 >nul
echo.
echo  ╔═══════════════════════════════════════════════════════════╗
echo  ║                  APPLICATION DEMARREE !                   ║
echo  ╚═══════════════════════════════════════════════════════════╝
echo.
echo  Acces :
echo    Frontend : http://localhost
echo    API      : http://localhost:5000
echo    Admin    : http://localhost/admin
echo.
pause
goto menu

:local
echo.
echo  Lancement en mode developpement...
echo.

REM Backend
echo  [1/2] Demarrage du Backend (port 5000)...
start "Elect27 Backend" cmd /k "cd backend && python -m venv venv && venv\Scripts\activate.bat && pip install -r requirements.txt && python app.py"

timeout /t 5 >nul

REM Frontend
echo  [2/2] Demarrage du Frontend (port 8080)...
start "Elect27 Frontend" cmd /k "cd frontend && python -m http.server 8080"

echo.
echo  ╔═══════════════════════════════════════════════════════════╗
echo  ║                  APPLICATION DEMARREE !                   ║
echo  ╚═══════════════════════════════════════════════════════════╝
echo.
echo  Acces :
echo    Frontend : http://localhost:8080
echo    API      : http://localhost:5000
echo.
pause
goto menu

:browser
echo.
echo  Ouverture du navigateur...
start http://localhost
timeout /t 2 >nul
goto menu

:stop
echo.
echo  Arret des conteneurs Docker...
docker-compose down
echo.
echo  Conteneurs arretes.
echo.
pause
goto menu

:end
exit
