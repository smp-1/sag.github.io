# ============================================
# ELECT27 - Script d'Arret
# ============================================
# Ce script arrete l'application Elect27
# Ports: 3000 (frontend) et 5000 (backend)
# ============================================

Write-Host ""
Write-Host "========================================" -ForegroundColor Yellow
Write-Host "   ELECT27 - Arret de l'Application" -ForegroundColor Yellow
Write-Host "========================================" -ForegroundColor Yellow
Write-Host ""

Write-Host "Arret des processus Python..." -ForegroundColor Red

$stopped = 0
Get-Process python -ErrorAction SilentlyContinue | ForEach-Object {
    Stop-Process -Id $_.Id -Force -ErrorAction SilentlyContinue
    Write-Host "  - Processus $($_.Id) arrete" -ForegroundColor Gray
    $stopped++
}

if ($stopped -eq 0) {
    Write-Host "  Aucun processus Python en cours d'execution" -ForegroundColor Gray
}

Start-Sleep -Seconds 1

# Verifier que les ports sont libres
$port5000 = netstat -an | Select-String ":5000.*LISTENING"
$port8080 = netstat -an | Select-String ":8080.*LISTENING"

Write-Host ""
if (-not $port5000 -and -not $port8080) {
    Write-Host "========================================" -ForegroundColor Green
    Write-Host "   APPLICATION ARRETEE AVEC SUCCES" -ForegroundColor Green
    Write-Host "========================================" -ForegroundColor Green
} else {
    Write-Host "========================================" -ForegroundColor Yellow
    Write-Host "   ATTENTION: Certains ports sont encore actifs" -ForegroundColor Yellow
    Write-Host "========================================" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "Pour relancer l'application:" -ForegroundColor Cyan
Write-Host "  lancer-elect27.ps1" -ForegroundColor White
Write-Host ""
