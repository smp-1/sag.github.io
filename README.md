# Elect27 - Application de Localisation des Lieux de Vote

Application web responsive pour la localisation des lieux de vote en Republique du Congo, developpee pour les elections legislatives et locales 2027.

> **Statut du projet (Septembre 2026) :** developpement termine, phase de **tests en cours**.
> Le backend tourne actuellement en **mode demo** (donnees en memoire) ; le schema PostgreSQL complet
> (migrations + seeds) est pret pour le basculement en production.

## Fonctionnalites

- **Recherche de lieu de vote** par nom, numero d'inscription ou adresse (avec auto-completion)
- **Carte interactive** avec geolocalisation des centres et bureaux de vote (Leaflet + OpenStreetMap)
- **Inscription electorale** en 3 etapes avec **verification du numero CNI** (13 caracteres) et anti-doublon
- **Verification d'inscription** prealable pour savoir si l'on est deja inscrit
- **Itineraire** pour se rendre au lieu de vote (distance, duree estimee, mode de transport)
- **Notifications electorales** (dates importantes, alertes de modification)
- **Dashboard d'administration** : statistiques, gestion des centres, electeurs, notifications
  et **carte des centres coloree selon le nombre d'electeurs inscrits**
- **Responsive mobile-first** (320px - 2560px) et accessible (WCAG 2.1 AA)

## Stack Technique

| Couche | Technologie |
|--------|-------------|
| Frontend | HTML5, CSS3, Tailwind CSS, JavaScript ES6+ |
| Carte | Leaflet.js 1.9 + OpenStreetMap |
| Backend | Python 3.11+ / Flask 3 (JWT, CORS, Rate limiting) |
| Base de donnees | PostgreSQL 15+ / PostGIS (prete, mode demo actuel) |
| ORM | SQLAlchemy 2 + Alembic (migrations) |
| Cache | Redis 7+ |
| Authentification | JWT (Flask-JWT-Extended) |
| Conteneurs | Docker / Docker Compose |
| Serveur Web | Nginx |

## Installation

### Pre-requis

- Python 3.11+ (mode local)
- Docker et Docker Compose (mode conteneurise, optionnel)
- Git

### Demarrage rapide (recommande)

**Windows (un double-clic suffit) :**

```bat
demarrer.bat
```

Ce script lance `lancer-elect27.ps1` : backend Flask (port 5000) + frontend statique (port 3000),
puis ouvre le navigateur. Pour arreter : `arreter.bat` (ou `arreter-elect27.ps1`).

**Alternative PowerShell :**

```powershell
.\start.ps1            # Docker si disponible, sinon mode local (frontend port 8080)
.\launch.ps1           # Menu interactif : docker / local / setup
.\lancer-elect27.ps1   # Mode local direct (frontend port 3000)
```

### Acces a l'application

| Service | URL (mode local `lancer-elect27.ps1`) | URL (mode local `start.ps1`) | URL (Docker) |
|---------|----------------------------------------|------------------------------|--------------|
| Frontend | http://localhost:3000 | http://localhost:8080 | http://localhost |
| API Backend | http://localhost:5000 | http://localhost:5000 | http://localhost:5000 |
| Admin | http://localhost:3000/admin/ | http://localhost:8080/admin/ | http://localhost/admin/ |

### Deploiement avec Docker

```bash
docker-compose up -d
```

Services : `web` (Flask), `frontend` (Nginx), `db` (PostGIS 15), `redis` (cache).

### Installation manuelle (developpement)

#### Backend

```bash
cd backend
python -m venv venv
venv\Scripts\activate     # Windows  (source venv/bin/activate sous Linux/Mac)
pip install -r requirements.txt
python app.py             # API sur le port 5000
```

Les variables d'environnement sont lues depuis `backend/.env` (fichier modele present dans le depot).

#### Frontend

Le frontend est un dossier statique :

```bash
cd frontend
python -m http.server 3000   # ou 8080 selon le script utilise
```

## Structure du Projet

```
Elect27/
├── frontend/                  # Frontend HTML/CSS/JS
│   ├── index.html             # Page d'accueil (recherche, stats, notifications)
│   ├── recherche.html         # Page de recherche (electeur / geographique)
│   ├── carte.html             # Carte interactive plein ecran
│   ├── inscription.html       # Inscription electorale 3 etapes (verification CNI)
│   ├── admin/
│   │   └── index.html         # Dashboard administration (login + onglets)
│   ├── css/main.css           # Styles CSS
│   └── js/
│       ├── api.js             # Client API
│       ├── carte.js           # Module carte Leaflet
│       └── app.js             # Script principal
│
├── backend/                   # Backend Python/Flask
│   ├── app.py                 # Application principale (mode demo, donnees en memoire)
│   ├── config.py              # Configuration (dev/prod/test)
│   ├── models/__init__.py     # Modeles SQLAlchemy (11 tables)
│   ├── routes/                # Blueprints API (recherche, geo, itineraire, notifications, admin)
│   ├── services/  middleware/  utils/   # Logique metier, middlewares, utilitaires
│   ├── requirements.txt       # Dependances
│   └── .env                   # Variables d'environnement
│
├── database/
│   ├── migrations/versions/001_initial.py  # Migration initiale (11 tables + index)
│   └── seeds/init.sql                      # Donnees initiales (departements, CNI, etc.)
│
├── docs & presentation
│   ├── README.md                      # Ce fichier
│   ├── specifications_techniques.md   # Specifications fonctionnelles / non-fonctionnelles
│   ├── backlog.md                     # Backlog (user stories par epic)
│   ├── architecture_initiale.md       # Architecture technique et schema BDD
│   ├── architecture_design_system.md  # Design tokens (DTCG) et composants
│   ├── Cahier_des_Charges_Elect27.docx
│   └── Presentation_Elect27.pptx      # Presentation projet
│
├── project_state.json         # Etat du workflow (phases, taches, journal)
├── demarrer.bat / arreter.bat # Lanceur / arret rapide (Windows)
├── lancer-elect27.ps1         # Lancement local (ports 3000 / 5000)
├── start.ps1 / launch.ps1     # Lanceurs alternatifs (Docker ou local)
├── docker-compose.yml         # Configuration Docker (web, nginx, db, redis)
└── nginx.conf                 # Configuration Nginx
```

## API Endpoints

Base URL : `http://localhost:5000/api/v1`

### Sante et statistiques
- `GET /health` - Verification de l'etat du service (mode demo)
- `GET /stats` - Statistiques globales (centres, bureaux, departements, communes, electeurs, CNI, notifications)

### Recherche
- `GET /recherche/electeur?q=` - Rechercher un electeur (nom, prenom, numero)
- `GET /recherche/centre?q=` - Rechercher un centre
- `GET /recherche/geographique?commune=&departement=` - Recherche geographique
- `GET /suggestions?q=` - Auto-completion (max 10 suggestions)

### Geolocalisation
- `GET /centres?commune=` - Liste des centres (coordonnees GPS)
- `GET /centres/:id` - Detail d'un centre (+ bureaux associes)
- `GET /bureaux?centre_id=` - Liste des bureaux
- `GET /proximite?lat=&lng=&radius=` - Centres proches (distance Haversine, tri par distance)

### Itineraire
- `GET /itineraire?lat_depart=&lon_depart=&lat_arrivee=&lon_arrivee=&mode=` -
  Calcul distance + duree estimee (modes : marche, voiture, transport_commun)

### Notifications
- `GET /notifications` - Notifications actives

### Inscription electorale
- `POST /inscription` - Inscrire un votant (validation CNI 13 caracteres, anti-doublon) - *5 req/min*
- `GET /inscription/verifier?q=` - Verifier si un electeur est deja inscrit

### Administration (JWT requis sauf login)
- `POST /admin/login` - Connexion (JWT access token 15 min)
- `GET /admin/dashboard` - Statistiques du tableau de bord
- `GET|POST /admin/centres` - Liste / creation de centres
- `GET /admin/electeurs?search=` - Liste / recherche d'electeurs
- `GET|POST /admin/notifications` - Liste / creation de notifications
- `GET /admin/verifier-cni?numero=` - Verification d'un numero CNI (existence, deja utilise)
- `GET /admin/electeurs-par-centre` - Nombre d'electeurs par centre (carte admin)

### Gestion des erreurs
- `404` - Ressource non trouvee
- `429` - Trop de requetes (rate limiting)
- `500` - Erreur interne

## Configuration

### Variables d'environnement (`backend/.env`)

| Variable | Description | Defaut |
|----------|-------------|--------|
| DATABASE_URL | URL de connexion PostgreSQL | postgresql://elect27:password@localhost:5432/elect27 |
| REDIS_URL | URL Redis | redis://localhost:6379/0 |
| JWT_SECRET_KEY | Cle secrete JWT | (a changer en production) |
| SECRET_KEY | Cle secrete Flask | (a changer en production) |
| JWT_ACCESS_TOKEN_EXPIRES | Duree du token (secondes) | 900 (15 min) |
| JWT_REFRESH_TOKEN_EXPIRES | Duree du refresh token | 604800 (7 jours) |
| CORS_ORIGINS | Domaines autorises | http://localhost:3000,8080,5000 |

### Compte admin de demonstration

| Champ | Valeur |
|-------|--------|
| Email | admin@elect27.cg |
| Mot de passe | admin123 |

> A **changer imperativement** avant toute mise en production.

## Modes d'execution

| Mode | Description | Donnees |
|------|-------------|---------|
| **Demo** (actuel) | `backend/app.py` avec donnees en memoire | 8 centres, 8 bureaux, 8 electeurs, 10 CNI, 3 notifications |
| **Production** | Docker Compose + PostgreSQL/PostGIS | Migration `001_initial.py` + `seeds/init.sql` |

Le passage de l'un a l'autre consiste a brancher les blueprints de `backend/routes/`
(qui s'appuient deja sur les modeles SQLAlchemy) sur l'application Flask.

## Securite

- Authentification JWT (access token 15 min)
- Rate limiting : 100 req/min par defaut, 30 req/min sur la recherche, 5 req/min sur l'inscription
- Validation des entrees cote serveur (longueur CNI, champs requis, anti-doublon)
- Protection CORS (origines a restreindre en production : `CORS_ORIGINS`)
- Headers de securite (CSP, XSS Protection, etc.) cote Nginx

> **A faire avant production :** restreindre CORS (actuellement `origins=['*']` en mode demo),
> hasher les mots de passe admin (bcrypt est deja une dependance), activer HTTPS/TLS 1.3.

## Accessibilite

- Conforme WCAG 2.1 Niveau AA (cible)
- Navigation clavier complete, focus visible
- Contraste de couleurs 4.5:1 minimum
- Responsive mobile-first (hamburger menu sur mobile, touch targets 44x44px)

## Tests

Phase en cours (`project_state.json` -> tache `test-001`) :
tests unitaires, integration et E2E a executer via `pytest` (dependances deja dans `requirements.txt`).

## Licence

Projet Developpe pour les Elections 2027 - Republique du Congo

## Contact

- Email : contact@elect27.cg
- Support : support@elect27.cg
