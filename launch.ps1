# ============================================
# Elect27 - Script de Lancement
# Application de Localisation des Lieux de Vote
# ============================================

param(
    [string]$Mode = "docker"  # docker, local, ou setup
)

# Couleurs pour le terminal
$Green = "`e[32m"
$Yellow = "`e[33m"
$Red = "`e[31m"
$Cyan = "`e[36m"
$Reset = "`e[0m"

function Write-Header {
    Clear-Host
    Write-Host ""
    Write-Host "  ╔═══════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
    Write-Host "  ║                                                           ║" -ForegroundColor Cyan
    Write-Host "  ║       ELECT27 - Lieux de Vote Congo 2027                  ║" -ForegroundColor Cyan
    Write-Host "  ║       Application de Localisation                         ║" -ForegroundColor Cyan
    Write-Host "  ║                                                           ║" -ForegroundColor Cyan
    Write-Host "  ╚═══════════════════════════════════════════════════════════╝" -ForegroundColor Cyan
    Write-Host ""
}

function Test-Docker {
    try {
        $dockerVersion = docker --version 2>$null
        $composeVersion = docker-compose --version 2>$null
        return ($dockerVersion -and $composeVersion)
    } catch {
        return $false
    }
}

function Test-Python {
    try {
        $pythonVersion = python --version 2>$null
        return [bool]$pythonVersion
    } catch {
        return $false
    }
}

function Test-PostgreSQL {
    try {
        $pgVersion = psql --version 2>$null
        return [bool]$pgVersion
    } catch {
        return $false
    }
}

function Start-Docker {
    Write-Host "  Lancement avec Docker Compose..." -ForegroundColor Green
    Write-Host ""
    
    # Verifier si Docker est en cours d'execution
    $dockerInfo = docker info 2>&1
    if ($LASTEXITCODE -ne 0) {
        Write-Host "  [ERREUR] Docker n'est pas en cours d'execution !" -ForegroundColor Red
        Write-Host "  Veuillez demarrer Docker Desktop et reessayer." -ForegroundColor Yellow
        return $false
    }
    
    # Lancer Docker Compose
    Write-Host "  Demarrage des conteneurs..." -ForegroundColor Yellow
    docker-compose up -d
    
    if ($LASTEXITCODE -ne 0) {
        Write-Host "  [ERREUR] Echec du lancement Docker" -ForegroundColor Red
        return $false
    }
    
    # Attendre que les services soient prets
    Write-Host ""
    Write-Host "  Attente du demarrage des services..." -ForegroundColor Yellow
    Start-Sleep -Seconds 10
    
    # Verifier l'etat des conteneurs
    Write-Host ""
    Write-Host "  Etat des conteneurs :" -ForegroundColor Cyan
    docker-compose ps
    
    return $true
}

function Start-Local {
    Write-Host "  Lancement en mode developpement local..." -ForegroundColor Green
    Write-Host ""
    
    $projectRoot = Split-Path -Parent $MyInvocation.ScriptName
    
    # Verifier Python
    if (-not (Test-Python)) {
        Write-Host "  [ERREUR] Python n'est pas installe !" -ForegroundColor Red
        return $false
    }
    
    # Lancer le Backend
    Write-Host "  [1/2] Preparation du Backend..." -ForegroundColor Yellow
    $backendPath = Join-Path $projectRoot "backend"
    
    if (-not (Test-Path "$backendPath\venv")) {
        Write-Host "       Creation de l'environnement virtuel..." -ForegroundColor Gray
        Push-Location $backendPath
        python -m venv venv
        Pop-Location
    }
    
    # Installer les dependances
    Write-Host "       Installation des dependances..." -ForegroundColor Gray
    Push-Location $backendPath
    & ".\venv\Scripts\Activate.ps1"
    pip install -r requirements.txt --quiet 2>$null
    Pop-Location
    
    # Demarrer le backend en arriere-plan
    Write-Host "       Demarrage du serveur Flask (port 5000)..." -ForegroundColor Gray
    $backendJob = Start-Process powershell -ArgumentList @(
        "-NoExit",
        "-Command",
        "cd '$backendPath'; .\venv\Scripts\Activate.ps1; python app.py"
    ) -PassThru
    
    Start-Sleep -Seconds 3
    
    # Lancer le Frontend
    Write-Host ""
    Write-Host "  [2/2] Demarrage du Frontend..." -ForegroundColor Yellow
    $frontendPath = Join-Path $projectRoot "frontend"
    
    Write-Host "       Demarrage du serveur HTTP (port 8080)..." -ForegroundColor Gray
    $frontendJob = Start-Process powershell -ArgumentList @(
        "-NoExit",
        "-Command",
        "cd '$frontendPath'; python -m http.server 8080"
    ) -PassThru
    
    return $true
}

function Show-Access {
    param([string]$FrontendUrl, [string]$ApiUrl, [string]$AdminUrl)
    
    Write-Host ""
    Write-Host "  ╔═══════════════════════════════════════════════════════════╗" -ForegroundColor Green
    Write-Host "  ║                  APPLICATION DEMARREE !                   ║" -ForegroundColor Green
    Write-Host "  ╚═══════════════════════════════════════════════════════════╝" -ForegroundColor Green
    Write-Host ""
    Write-Host "  Acces a l'application :" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "    🌐 Frontend    : $FrontendUrl" -ForegroundColor Yellow
    Write-Host "    🔌 API Backend : $ApiUrl" -ForegroundColor Yellow
    Write-Host "    👑 Admin       : $AdminUrl" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "  Pages disponibles :" -ForegroundColor Cyan
    Write-Host "    - Accueil     : $FrontendUrl/" -ForegroundColor Gray
    Write-Host "    - Recherche   : $FrontendUrl/recherche.html" -ForegroundColor Gray
    Write-Host "    - Carte       : $FrontendUrl/carte.html" -ForegroundColor Gray
    Write-Host "    - Admin       : $FrontendUrl/admin/" -ForegroundColor Gray
    Write-Host ""
}

function Show-Menu {
    Write-Host "  Selectionnez le mode de lancement :" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "    [1] Docker (Recommande)" -ForegroundColor Yellow
    Write-Host "        - Utilise Docker Compose" -ForegroundColor Gray
    Write-Host "        - PostgreSQL et Redis inclus" -ForegroundColor Gray
    Write-Host ""
    Write-Host "    [2] Developpement Local" -ForegroundColor Yellow
    Write-Host "        - Necessite Python et PostgreSQL" -ForegroundColor Gray
    Write-Host "        - Frontend sur port 8080" -ForegroundColor Gray
    Write-Host ""
    Write-Host "    [3] Installation initiale" -ForegroundColor Yellow
    Write-Host "        - Installe les dependances" -ForegroundColor Gray
    Write-Host "        - Configure la base de donnees" -ForegroundColor Gray
    Write-Host ""
    Write-Host "    [4] Arreter l'application" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "    [Q] Quitter" -ForegroundColor Red
    Write-Host ""
}

# ============================================
# PROGRAMME PRINCIPAL
# ============================================

Write-Header

# Menu interactif si aucun mode specifie
if ($Mode -eq "menu") {
    do {
        Show-Menu
        $choice = Read-Host "  Votre choix"
        
        switch ($choice) {
            "1" { $Mode = "docker"; break }
            "2" { $Mode = "local"; break }
            "3" { $Mode = "setup"; break }
            "4" { 
                Write-Host ""
                Write-Host "  Arret des conteneurs Docker..." -ForegroundColor Yellow
                docker-compose down 2>$null
                Write-Host "  Conteneurs arretes." -ForegroundColor Green
                Write-Host ""
                pause
                exit
            }
            "Q" { exit }
            "q" { exit }
            default { 
                Write-Host "  Choix invalide !" -ForegroundColor Red
                Start-Sleep -Seconds 1
            }
        }
    } while ($Mode -notin @("docker", "local", "setup"))
}

# Executer selon le mode
switch ($Mode) {
    "docker" {
        if (Test-Docker) {
            $success = Start-Docker
            if ($success) {
                Show-Access -FrontendUrl "http://localhost" -ApiUrl "http://localhost:5000" -AdminUrl "http://localhost/admin"
            }
        } else {
            Write-Host "  [ERREUR] Docker n'est pas installe !" -ForegroundColor Red
            Write-Host "  Installez Docker Desktop : https://www.docker.com/products/docker-desktop" -ForegroundColor Yellow
        }
    }
    
    "local" {
        $success = Start-Local
        if ($success) {
            Show-Access -FrontendUrl "http://localhost:8080" -ApiUrl "http://localhost:5000" -AdminUrl "http://localhost:8080/admin/"
        }
    }
    
    "setup" {
        Write-Host "  Installation initiale du projet..." -ForegroundColor Green
        Write-Host ""
        
        $projectRoot = Split-Path -Parent $MyInvocation.ScriptName
        $backendPath = Join-Path $projectRoot "backend"
        
        # Creer l'environnement virtuel Python
        Write-Host "  [1/3] Creation de l'environnement Python..." -ForegroundColor Yellow
        Push-Location $backendPath
        python -m venv venv
        & ".\venv\Scripts\Activate.ps1"
        Write-Host "       OK" -ForegroundColor Green
        
        # Installer les dependances
        Write-Host "  [2/3] Installation des dependances Python..." -ForegroundColor Yellow
        pip install -r requirements.txt
        Write-Host "       OK" -ForegroundColor Green
        
        # Initialiser la base de donnees
        Write-Host "  [3/3] Initialisation de la base de donnees..." -ForegroundColor Yellow
        Write-Host "       Assurez-vous que PostgreSQL est en cours d'execution" -ForegroundColor Gray
        
        try {
            $env:PGPASSWORD = "password"
            psql -U elect27 -d elect27 -f "..\database\seeds\init.sql" 2>$null
            Write-Host "       OK" -ForegroundColor Green
        } catch {
            Write-Host "       [ATTENTION] Erreur lors de l'initialisation BDD" -ForegroundColor Yellow
            Write-Host "       Verifiez que PostgreSQL est accessible" -ForegroundColor Gray
        }
        
        Pop-Location
        
        Write-Host ""
        Write-Host "  Installation terminee !" -ForegroundColor Green
        Write-Host "  Lancez l'application avec : .\launch.ps1 -Mode docker" -ForegroundColor Cyan
        Write-Host ""
    }
}

Write-Host ""
Write-Host "  Appuyez sur une touche pour continuer..." -ForegroundColor Gray
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
