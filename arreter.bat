@echo off
title ELECT27 - Arret
echo.
echo ========================================
echo   ELECT27 - Arret de l'Application
echo ========================================
echo.

echo Arret des processus...
echo.

:: Verifier si PowerShell est disponible
where powershell >nul 2>nul
if %errorlevel% equ 0 (
    powershell -ExecutionPolicy Bypass -File "%~dp0arreter-elect27.ps1"
) else (
    echo Arret des processus Python...
    taskkill /F /IM python.exe /T >nul 2>nul
    echo.
    echo Application arretee!
)

pause
