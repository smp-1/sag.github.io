@echo off
title ELECT27 - Lancement
echo.
echo ========================================
echo   ELECT27 - Application de Localisation
echo   des Lieux de Vote - Congo 2027
echo ========================================
echo.

echo Demarrage de l'application...
echo.

:: Verifier si PowerShell est disponible
where powershell >nul 2>nul
if %errorlevel% equ 0 (
    powershell -ExecutionPolicy Bypass -File "%~dp0lancer-elect27.ps1"
) else (
    echo ERREUR: PowerShell n'est pas disponible!
    echo Veuillez installer PowerShell ou executer le script .ps1 directement.
    pause
)
