# ============================================
# Elect27 - Lanceur Rapide
# ============================================
# Utilisation : .\start.ps1
# ============================================

Write-Host ""
Write-Host "  ELECT27 - Demarrage rapide" -ForegroundColor Cyan
Write-Host "  =========================" -ForegroundColor Cyan
Write-Host ""

# Verifier Docker
$dockerReady = $false
try {
    docker info 2>&1 | Out-Null
    $dockerReady = $LASTEXITCODE -eq 0
} catch {}

if ($dockerReady) {
    Write-Host "  Docker detecte. Lancement avec Docker Compose..." -ForegroundColor Green
    Write-Host ""
    
    docker-compose up -d
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host ""
        Write-Host "  Demarrage en cours..." -ForegroundColor Yellow
        Start-Sleep -Seconds 10
        
        Write-Host ""
        Write-Host "  Application prete !" -ForegroundColor Green
        Write-Host ""
        Write-Host "  -> Frontend : http://localhost" -ForegroundColor Yellow
        Write-Host "  -> API      : http://localhost:5000" -ForegroundColor Yellow
        Write-Host "  -> Admin    : http://localhost/admin" -ForegroundColor Yellow
        Write-Host ""
        
        # Ouvrir le navigateur
        $ouvrir = Read-Host "  Ouvrir le navigateur ? (O/N)"
        if ($ouvrir -eq "O" -or $ouvrir -eq "o") {
            Start-Process "http://localhost"
        }
    } else {
        Write-Host "  Erreur lors du lancement Docker" -ForegroundColor Red
    }
} else {
    Write-Host "  Docker non detecte. Lancement en mode local..." -ForegroundColor Yellow
    Write-Host ""
    
    $projectRoot = $PSScriptRoot
    
    # Backend
    Write-Host "  Demarrage du backend..." -ForegroundColor Gray
    Start-Process powershell -ArgumentList @(
        "-NoExit",
        "-Command",
        "cd '$projectRoot\backend'; python -m venv venv; .\venv\Scripts\Activate.ps1; pip install -r requirements.txt; python app.py"
    )
    
    Start-Sleep -Seconds 3
    
    # Frontend
    Write-Host "  Demarrage du frontend..." -ForegroundColor Gray
    Start-Process powershell -ArgumentList @(
        "-NoExit",
        "-Command",
        "cd '$projectRoot\frontend'; python -m http.server 8080"
    )
    
    Write-Host ""
    Write-Host "  Application prete !" -ForegroundColor Green
    Write-Host ""
    Write-Host "  -> Frontend : http://localhost:8080" -ForegroundColor Yellow
    Write-Host "  -> API      : http://localhost:5000" -ForegroundColor Yellow
    Write-Host ""
}

Write-Host "  Appuyez sur Entree pour continuer..." -ForegroundColor Gray
Read-Host
