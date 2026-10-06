# Architecture Initiale - Elect27 Web App

> **Mise a jour (Septembre 2026) :** structure ci-dessous alignee sur le code reellement livre.
> Le backend `backend/app.py` tourne en **mode demo** (donnees en memoire) ; les blueprints
> `backend/routes/` et modeles SQLAlchemy sont prets pour le branchement PostgreSQL.

## 1. Architecture Technique

### 1.1 Vue d'ensemble

```
┌─────────────────────────────────────────────────────────────────┐
│                        CLIENT (Browser)                         │
│  ┌─────────────┐  ┌───────────────────┐  ┌─────────────────────┐│
│  │   HTML5     │  │  CSS3/Tailwind CDN│  │  JavaScript ES6+    ││
│  │  Structure  │  │      Style        │  │  Logique applicative││
│  └─────────────┘  └───────────────────┘  └─────────────────────┘│
│  ┌─────────────────────────────────────────────────────────────┐│
│  │              Leaflet.js + OpenStreetMap                      ││
│  └─────────────────────────────────────────────────────────────┘│
└─────────────────────────────────────────────────────────────────┘
                              │
                         HTTPS/REST (JSON)
                              │
┌─────────────────────────────────────────────────────────────────┐
│                     SERVEUR (Python / Flask 3)                   │
│  ┌─────────────────────────────────────────────────────────────┐│
│  │  app.py (mode demo : donnees en memoire CENTRES/NOTIFS...)  ││
│  │  ┌─────────────┐  ┌─────────────┐  ┌─────────────────────┐ ││
│  │  │  Endpoints  │  │  Blueprints │  │   Middleware         │ ││
│  │  │  /api/v1/*  │  │ routes/*.py │  │  JWT, CORS, Limiter  │ ││
│  │  └─────────────┘  └─────────────┘  └─────────────────────┘ ││
│  └─────────────────────────────────────────────────────────────┘│
│  ┌─────────────────────────────────────────────────────────────┐│
│  │                    SQLAlchemy ORM (pret)                     ││
│  │  ┌─────────────┐  ┌─────────────┐  ┌─────────────────────┐ ││
│  │  │   Models    │  │   Query     │  │   Migrations        │ ││
│  │  │  11 tables  │  │   Builder   │  │   (Alembic 001)     │ ││
│  │  └─────────────┘  └─────────────┘  └─────────────────────┘ ││
│  └─────────────────────────────────────────────────────────────┘│
└─────────────────────────────────────────────────────────────────┘
                              │
┌─────────────────────────────────────────────────────────────────┐
│                     BASE DE DONNEES                              │
│  ┌─────────────────────┐  ┌─────────────────────────────────┐  │
│  │ PostgreSQL 15 + PostGIS│ │        Redis 7 (Cache)         │  │
│  │ (Docker, seeds prets) │  │                                │  │
│  └─────────────────────┘  └─────────────────────────────────┘  │
└─────────────────────────────────────────────────────────────────┘
```

### 1.2 Structure des Dossiers (reelle, livree)

```
Elect27/
├── frontend/
│   ├── index.html              # Accueil : recherche, stats, notifications
│   ├── recherche.html          # Recherche electeur / geographique
│   ├── carte.html              # Carte interactive plein ecran
│   ├── inscription.html        # Inscription electorale 3 etapes (CNI)
│   ├── admin/
│   │   └── index.html          # Dashboard admin (login + onglets, carte electeurs)
│   ├── css/
│   │   └── main.css            # Styles principaux
│   └── js/
│       ├── app.js              # Script principal
│       ├── api.js              # Client API
│       └── carte.js            # Gestion carte Leaflet
│
├── backend/
│   ├── app.py                  # Application Flask (MODE DEMO - donnees en memoire)
│   ├── config.py               # Configuration (dev/prod/test)
│   ├── requirements.txt        # Dependances Python
│   ├── .env                    # Variables d'environnement
│   ├── models/
│   │   └── __init__.py         # 11 modeles SQLAlchemy
│   ├── routes/
│   │   ├── __init__.py
│   │   ├── recherche.py        # Routes de recherche (SQLAlchemy)
│   │   ├── geolocalisation.py  # Routes carte
│   │   ├── itineraire.py       # Routes itineraire
│   │   ├── notifications.py    # Routes notifications
│   │   └── admin.py            # Auth, centres, electeurs, dashboard, CNI
│   ├── services/               # Logique metier (geocoding, search, notification)
│   ├── middleware/              # Auth JWT, CORS, rate limiting
│   └── utils/                  # Validators, helpers
│
├── database/
│   ├── migrations/
│   │   ├── alembic.ini
│   │   ├── env.py
│   │   └── versions/
│   │       └── 001_initial.py  # 11 tables + index + PostGIS
│   └── seeds/
│       └── init.sql            # Departements, communes, centres, CNI, admin
│
├── docs & presentation (racine)
│   ├── README.md
│   ├── specifications_techniques.md
│   ├── backlog.md
│   ├── architecture_initiale.md
│   ├── architecture_design_system.md
│   ├── Cahier_des_Charges_Elect27.docx
│   └── Presentation_Elect27.pptx
│
├── project_state.json          # Etat du workflow
├── demarrer.bat / arreter.bat  # Lanceur / arret rapide Windows
├── lancer-elect27.ps1          # Lancement local (3000 / 5000)
├── arreter-elect27.ps1
├── start.ps1 / launch.ps1      # Lanceurs Docker ou local
├── docker-compose.yml          # web, nginx, db (PostGIS), redis
├── nginx.conf
└── .gitignore

> A venir (sprints de polish / tests) :
> - frontend/itineraire.html (lien depuis carte.html actuellement casse)
> - tests/unit, tests/integration, tests/e2e
> - import CSV electeurs, export CSV dashboard
```

## 2. Stack Technique Detaillee

### 2.1 Frontend

| Technologie | Version | Usage |
|-------------|---------|-------|
| HTML5 | - | Structure semantique |
| CSS3 | - | Styles |
| Tailwind CSS | 3.4+ | Framework CSS utility-first |
| JavaScript | ES6+ | Logique applicative |
| Leaflet.js | 1.9+ | Carte interactive |
| OpenStreetMap | - | Donnees cartographiques |
| Chart.js | 4.0+ | Graphiques dashboard admin |

### 2.2 Backend

| Technologie | Version | Usage |
|-------------|---------|-------|
| Python | 3.11+ | Langage principal |
| Flask | 3.0+ | Framework web |
| Flask-RESTful | 0.3+ | API REST |
| Flask-JWT-Extended | 4.5+ | Authentification JWT |
| Flask-CORS | 4.0+ | Gestion CORS |
| Flask-Limiter | 3.0+ | Rate limiting |
| SQLAlchemy | 2.0+ | ORM |
| Alembic | 1.12+ | Migrations BDD |
| Marshmallow | 3.0+ | Validation/Serialisation |
| Psycopg2 | 2.9+ | Driver PostgreSQL |
| Flask-Swagger-UI | 4.0+ | Documentation API |

### 2.3 Base de Donnees

| Technologie | Version | Usage |
|-------------|---------|-------|
| PostgreSQL | 15+ | Base de donnees |
| PostGIS | 3.3+ | Donnees spatiales |
| Redis | 7.0+ | Cache, sessions |

## 3. Modele de Donnees Detaille

### 3.1 Schema Relationnel

```sql
-- Table des departements
CREATE TABLE departements (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    code VARCHAR(10) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table des communes
CREATE TABLE communes (
    id SERIAL PRIMARY KEY,
    departement_id INTEGER REFERENCES departements(id) ON DELETE CASCADE,
    nom VARCHAR(100) NOT NULL,
    code VARCHAR(10) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table des arrondissements
CREATE TABLE arrondissements (
    id SERIAL PRIMARY KEY,
    commune_id INTEGER REFERENCES communes(id) ON DELETE CASCADE,
    nom VARCHAR(100) NOT NULL,
    code VARCHAR(10) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table des quartiers
CREATE TABLE quartiers (
    id SERIAL PRIMARY KEY,
    arrondissement_id INTEGER REFERENCES arrondissements(id) ON DELETE CASCADE,
    nom VARCHAR(100) NOT NULL,
    code VARCHAR(10) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table des centres de vote
CREATE TABLE centres_vote (
    id SERIAL PRIMARY KEY,
    commune_id INTEGER REFERENCES communes(id) ON DELETE SET NULL,
    nom VARCHAR(200) NOT NULL,
    adresse TEXT NOT NULL,
    latitude DECIMAL(10, 8) NOT NULL,
    longitude DECIMAL(11, 8) NOT NULL,
    type VARCHAR(50) DEFAULT 'centre',
    capacite INTEGER,
    horaires TEXT,
    telephone VARCHAR(20),
    email VARCHAR(100),
    actif BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table des bureaux de vote
CREATE TABLE bureaux_vote (
    id SERIAL PRIMARY KEY,
    centre_vote_id INTEGER REFERENCES centres_vote(id) ON DELETE CASCADE,
    numero INTEGER NOT NULL,
    nom VARCHAR(100),
    capacite INTEGER,
    latitude DECIMAL(10, 8),
    longitude DECIMAL(11, 8),
    actif BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(centre_vote_id, numero)
);

-- Table des electeurs
CREATE TABLE electeurs (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    prenom VARCHAR(100),
    numero_inscription VARCHAR(50) UNIQUE NOT NULL,
    numero_cni VARCHAR(13),
    date_naissance DATE,
    sexe CHAR(1),
    adresse TEXT,
    quartier_id INTEGER REFERENCES quartiers(id) ON DELETE SET NULL,
    bureau_vote_id INTEGER REFERENCES bureaux_vote(id) ON DELETE SET NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table des cartes d'identite (verification CNI / inscription)
CREATE TABLE cartes_identite (
    id SERIAL PRIMARY KEY,
    numero_cni VARCHAR(13) UNIQUE NOT NULL,
    nom VARCHAR(100) NOT NULL,
    prenom VARCHAR(100),
    date_naissance DATE,
    lieu_naissance VARCHAR(100),
    sexe CHAR(1),
    date_delivrance DATE,
    date_expiration DATE,
    actif BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table des utilisateurs admin
CREATE TABLE admin_users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    role VARCHAR(20) DEFAULT 'viewer',
    actif BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    last_login TIMESTAMP
);

-- Table des notifications
CREATE TABLE notifications (
    id SERIAL PRIMARY KEY,
    titre VARCHAR(200) NOT NULL,
    message TEXT NOT NULL,
    type VARCHAR(50) DEFAULT 'info',
    date_publication TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    date_expiration TIMESTAMP,
    active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table des statistiques de recherche
CREATE TABLE stats_recherche (
    id SERIAL PRIMARY KEY,
    date_recherche TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    type_recherche VARCHAR(50),
    zone VARCHAR(100),
    succes BOOLEAN,
    duree_ms INTEGER
);

-- Index pour performance
CREATE INDEX idx_electeurs_nom ON electeurs(nom, prenom);
CREATE INDEX idx_electeurs_numero ON electeurs(numero_inscription);
CREATE INDEX idx_electeurs_cni ON electeurs(numero_cni);
CREATE INDEX idx_electeurs_bureau ON electeurs(bureau_vote_id);
CREATE INDEX idx_cartes_cni ON cartes_identite(numero_cni);
CREATE INDEX idx_centres_commune ON centres_vote(commune_id);
CREATE INDEX idx_bureaux_centre ON bureaux_vote(centre_vote_id);
CREATE INDEX idx_stats_date ON stats_recherche(date_recherche);

-- Extension PostGIS pour geolocalisation
CREATE EXTENSION IF NOT EXISTS postgis;

-- Index spatial pour les centres
CREATE INDEX idx_centres_location ON centres_vote USING GIST (
    ST_SetSRID(ST_MakePoint(longitude, latitude), 4326)
);
```

## 4. Configuration

### 4.1 Variables d'Environnement

```env
# Database
DATABASE_URL=postgresql://user:password@localhost:5432/elect27
DATABASE_HOST=localhost
DATABASE_PORT=5432
DATABASE_NAME=elect27
DATABASE_USER=elect27_user
DATABASE_PASSWORD=secure_password_here

# Redis
REDIS_URL=redis://localhost:6379/0

# JWT
JWT_SECRET_KEY=super-secret-key-change-in-production
JWT_ACCESS_TOKEN_EXPIRES=900
JWT_REFRESH_TOKEN_EXPIRES=604800

# Flask
FLASK_ENV=development
FLASK_DEBUG=1
SECRET_KEY=flask-secret-key-change-in-production

# API Keys (optionnel)
OPENSTREETMAP_API_KEY=

# CORS
CORS_ORIGINS=http://localhost:3000,http://localhost:8080
```

### 4.2 Requirements.txt

```txt
# Core
Flask==3.0.0
Flask-RESTful==0.3.10
Flask-CORS==4.0.0
Flask-JWT-Extended==4.6.0
Flask-Limiter==3.5.0
Flask-Swagger-UI==4.0.0

# Database
SQLAlchemy==2.0.23
alembic==1.13.0
psycopg2-binary==2.9.9
redis==5.0.1

# Validation
marshmallow==3.20.1
webargs==5.8.2

# Security
bcrypt==4.1.2
python-dotenv==1.0.0

# Utils
gunicorn==21.2.0
python-dateutil==2.8.2
```

## 5. Deployment

### 5.1 Docker

```dockerfile
# Dockerfile
FROM python:3.11-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 5000

CMD ["gunicorn", "--bind", "0.0.0.0:5000", "app:app"]
```

### 5.2 Docker Compose

```yaml
version: '3.8'

services:
  web:
    build: .
    ports:
      - "5000:5000"
    environment:
      - DATABASE_URL=postgresql://elect27:password@db:5432/elect27
      - REDIS_URL=redis://redis:6379/0
    depends_on:
      - db
      - redis

  db:
    image: postgis/postgis:15-3.3
    environment:
      - POSTGRES_DB=elect27
      - POSTGRES_USER=elect27
      - POSTGRES_PASSWORD=password
    volumes:
      - postgres_data:/var/lib/postgresql/data
    ports:
      - "5432:5432"

  redis:
    image: redis:7-alpine
    ports:
      - "6379:6379"

volumes:
  postgres_data:
```

## 6. Security Considerations

1. **Authentication**: JWT avec refresh token rotation
2. **Authorization**: RBAC (admin, editor, viewer)
3. **Input Validation**: Cote serveur avec Marshmallow
4. **SQL Injection**: Parameterized queries via SQLAlchemy
5. **XSS**: Output encoding + CSP headers
6. **Rate Limiting**: 100 req/min (public), 1000 req/min (admin)
7. **HTTPS**: TLS 1.3 en production
8. **Secrets**: Variables d'environnement, jamais en dur
