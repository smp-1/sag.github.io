# ============================================
# ELECT27 - Script de Lancement
# ============================================
# Ce script demarre l'application Elect27
# Frontend: http://localhost:3000
# Backend:  http://localhost:5000
# ============================================

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "   ELECT27 - Application de Localisation" -ForegroundColor Cyan
Write-Host "   des Lieux de Vote - Congo 2027" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Repertoire du projet
$ProjectRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$BackendPath = Join-Path $ProjectRoot "backend"
$FrontendPath = Join-Path $ProjectRoot "frontend"

Write-Host "[1/4] Arret des anciens processus..." -ForegroundColor Yellow

# Arreter les anciens processus Python
Get-Process python -ErrorAction SilentlyContinue | ForEach-Object {
    Stop-Process -Id $_.Id -Force -ErrorAction SilentlyContinue
    Write-Host "  - Processus Python $($_.Id) arrete" -ForegroundColor Gray
}
Start-Sleep -Seconds 1

Write-Host "[2/4] Verification des dependances..." -ForegroundColor Yellow

# Verifier que Python est installe
try {
    $pythonVersion = python --version 2>&1
    Write-Host "  - Python: $pythonVersion" -ForegroundColor Green
} catch {
    Write-Host "  - ERREUR: Python non trouve!" -ForegroundColor Red
    exit 1
}

# Installer les dependances si necessaire
Write-Host "[3/4] Installation des dependances..." -ForegroundColor Yellow
Push-Location $BackendPath

# Verifier si Flask est installe
$flaskInstalled = python -c "import flask" 2>&1
if ($LASTEXITCODE -ne 0) {
    Write-Host "  - Installation de Flask..." -ForegroundColor Gray
    pip install --trusted-host pypi.org --trusted-host files.pythonhosted.org flask flask-cors flask-jwt-extended flask-limiter python-dotenv --quiet 2>&1 | Out-Null
}

Pop-Location

Write-Host "[4/4] Demarrage des serveurs..." -ForegroundColor Yellow

# Demarrer le Backend (Flask)
Write-Host "  - Demarrage du Backend (port 5000)..." -ForegroundColor Gray
Start-Process -FilePath "python" -ArgumentList "app.py" -WorkingDirectory $BackendPath -WindowStyle Hidden
Start-Sleep -Seconds 3

# Demarrer le Frontend (Serveur HTTP) sur le port 3000
Write-Host "  - Demarrage du Frontend (port 3000)..." -ForegroundColor Gray
Start-Process -FilePath "python" -ArgumentList "-m http.server 3000" -WorkingDirectory $FrontendPath -WindowStyle Hidden
Start-Sleep -Seconds 2

# Verifier les ports
$backendOK = netstat -an | Select-String ":5000.*LISTENING"
$frontendOK = netstat -an | Select-String ":3000.*LISTENING"

Write-Host ""
Write-Host "========================================" -ForegroundColor Green
Write-Host "   SERVEURS DEMARRES AVEC SUCCES!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""
Write-Host "  Frontend: http://localhost:3000" -ForegroundColor White
Write-Host "  Backend:  http://localhost:5000" -ForegroundColor White
Write-Host ""

if ($backendOK -and $frontendOK) {
    Write-Host "  Status: TOUS LES SERVICES SONT EN MARCHE" -ForegroundColor Green
} else {
    Write-Host "  Status: Attention - un service peut ne pas etre demarre" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "Pages disponibles:" -ForegroundColor Cyan
Write-Host "  - Accueil:    http://localhost:3000" -ForegroundColor White
Write-Host "  - Recherche:  http://localhost:3000/recherche.html" -ForegroundColor White
Write-Host "  - Carte:      http://localhost:3000/carte.html" -ForegroundColor White
Write-Host ""
Write-Host "Pour arreter l'application, executez:" -ForegroundColor Yellow
Write-Host "  arreter-elect27.ps1" -ForegroundColor White
Write-Host ""

# Ouvrir le navigateur
Start-Process "http://localhost:3000"

Write-Host "Le navigateur s'est ouvert. Appuyez sur Entree pour quitter..." -ForegroundColor Gray
Read-Host
