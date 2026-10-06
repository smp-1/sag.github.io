# Specifications Techniques - Elect27 Web App

## 1. Vue d'ensemble

**Nom du projet:** Elect27 - Application de Localisation des Lieux de Vote  
**Version:** 1.1  
**Date:** Septembre 2026 (mise a jour)  
**Statut:** Developpement termine - phase de tests en cours  
**Objectif:** Plateforme web responsive pour faciliter l'acces des citoyens a leur lieu de vote en Republique du Congo.

> **Note d'implementation (v1.1):** le backend fonctionne actuellement en **mode demo**
> (donnees en memoire dans `backend/app.py`), tandis que les modeles SQLAlchemy, la migration
> Alembic `001_initial` et les seeds `init.sql` sont prets pour le basculement PostgreSQL.
> Les blueprints de `backend/routes/` implementent deja les memes flux cote base de donnees.

## 2. Exigences Fonctionnelles

### 2.1 Module de Recherche

| ID | Fonctionnalite | Description | Priorite |
|----|----------------|-------------|----------|
| RF-001 | Recherche par nom | Rechercher un lieu de vote par nom du centre/bureau | P0 |
| RF-002 | Recherche par numero | Rechercher par numero d'inscription electorale | P0 |
| RF-003 | Recherche par adresse | Rechercher par adresse ou localisation | P0 |
| RF-004 | Recherche geographique | Recherche par departement, commune, arrondissement, quartier | P0 |
| RF-005 | Auto-completion | Suggestions pendant la saisie | P1 |
| RF-006 | Recherche avancee | Filtres combines (departement + commune + quartier) | P1 |

### 2.2 Module de Geocalisation

| ID | Fonctionnalite | Description | Priorite |
|----|----------------|-------------|----------|
| RG-001 | Carte interactive | Affichage des lieux de vote sur une carte (Leaflet) | P0 |
| RG-002 | Marqueurs | Markers pour chaque centre/bureau de vote | P0 |
| RG-003 | Popups information | Details du lieu au clic sur le marker | P0 |
| RG-004 | Geolocalisation utilisateur | Position actuelle de l'utilisateur | P1 |
| RG-005 | Zoom intelligent | Auto-zoom sur la zone de recherche | P1 |
| RG-006 | Filtres carte | Filtrer par type (centre/bureau) | P2 |

### 2.3 Module d'Itineraire

| ID | Fonctionnalite | Description | Priorite |
|----|----------------|-------------|----------|
| RI-001 | Calcul d'itineraire | Trajet depuis la position utilisateur vers le lieu de vote | P1 |
| RI-002 | Plusieurs modes | Marche, voiture, transport en commun | P2 |
| RI-003 | Instructions | Etapes detaillees de l'itineraire | P2 |
| RI-004 | Distance et duree | Affichage de la distance et du temps estime | P1 |

### 2.4 Module de Notification

| ID | Fonctionnalite | Description | Priorite |
|----|----------------|-------------|----------|
| RN-001 | Notifications push | Alertes pour informations electorales importantes | P1 |
| RN-002 | Dates electorales | Rappels des dates importantes | P1 |
| RN-003 | Modifications | Alertes de changement de bureau/centre | P0 |
| RN-004 | Parametres | Gestion des preferences de notification | P2 |

### 2.5 Module d'Inscription Electorale (nouveau en v1.1)

| ID | Fonctionnalite | Description | Priorite |
|----|----------------|-------------|----------|
| RI-001 | Verification CNI | Verifier un numero CNI (13 chiffres) aupres de la base des cartes d'identite | P0 |
| RI-002 | Anti-doublon CNI | Empecher l'utilisation d'un CNI deja ratache a un electeur | P0 |
| RI-003 | Formulaire 3 etapes | Informations personnelles > Choix du centre > Confirmation | P0 |
| RI-004 | Verification d'inscription prealable | Verifier si l'electeur est deja inscrit avant le formulaire | P0 |
| RI-005 | Attribution de numero | Generation automatique du numero d'inscription (format EC2027XXXX) | P0 |
| RI-006 | Anti-doublon identite | Empecher deux inscriptions pour le meme nom/prenom | P0 |
| RI-007 | Ecran de confirmation | Afficher le numero d'inscription et le centre attribue | P0 |

### 2.6 Module d'Administration

| ID | Fonctionnalite | Description | Priorite |
|----|----------------|-------------|----------|
| RA-001 | Dashboard | Vue d'ensemble des statistiques | P0 |
| RA-002 | Gestion centres | CRUD des centres de vote | P0 |
| RA-003 | Gestion bureaux | CRUD des bureaux de vote | P0 |
| RA-004 | Gestion electeurs | Import/export des listes electorales | P1 |
| RA-005 | Publication | Publier des informations electorales | P1 |
| RA-006 | Logs | Historique des actions administrateur | P2 |
| RA-007 | Utilisateurs | Gestion des comptes administrateurs | P1 |

## 3. Exigences Non-Fonctionnelles

### 3.1 Performance

| ID | Exigence | Mesure |
|----|----------|--------|
| RNF-001 | Temps de chargement initial | < 3 secondes |
| RNF-002 | Temps de reponse API | < 500ms |
| RNF-003 | Temps de recherche | < 1 seconde |
| RNF-004 | Temps de rendu carte | < 2 secondes |
| RNF-005 | Disponibilite | 99.5% |

### 3.2 Securite

| ID | Exigence | Standard |
|----|----------|----------|
| RS-001 | Authentification admin | JWT avec refresh token |
| RS-002 | Hash mots de passe | bcrypt (12 rounds) |
| RS-003 | Protection injection | SQL injection, XSS |
| RS-004 | CORS | Configuration restrictive |
| RS-005 | Rate limiting | Protection brute force |
| RS-006 | HTTPS | TLS 1.3 obligatoire |
| RS-007 | Validation entrees | Cote serveur et client |

### 3.3 Accessibilite

| ID | Exigence | Standard |
|----|----------|----------|
| RA-001 | Contraste couleur | WCAG 2.1 AA (4.5:1) |
| RA-002 | Navigation clavier | Totalement navigable |
| RA-003 | Lecteur d'ecran | ARIA labels, roles |
| RA-004 | Responsive | Mobile-first, 320px-2560px |
| RA-005 | Touch targets | Min 44x44px |

### 3.4 Compatibilite

| ID | Exigence | Details |
|----|----------|---------|
| RC-001 | Navigateurs | Chrome, Firefox, Safari, Edge (2 dernières versions) |
| RC-002 | Mobile | iOS 14+, Android 10+ |
| RC-003 | Tablettes | iPad, Android tablet |
| RC-004 | Desktop | Windows, macOS, Linux |

## 4. Architecture Technique

### 4.1 Architecture 3-Tiers

```
┌─────────────────────────────────────────────────────┐
│                   PRESENTATION                       │
│  HTML + CSS (Tailwind) + JavaScript (Vanilla/ES6)   │
│  Leaflet.js (Cartes)                                 │
└──────────────────────┬──────────────────────────────┘
                       │ API REST (HTTPS)
┌──────────────────────▼──────────────────────────────┐
│                 LOGIQUE METIER                       │
│  Python 3.11+                                        │
│  Flask / FastAPI                                     │
│  SQLAlchemy (ORM)                                    │
│  Marshmallow (Validation)                            │
└──────────────────────┬──────────────────────────────┘
                       │
┌──────────────────────▼──────────────────────────────┐
│                   DONNEES                            │
│  PostgreSQL 15+                                      │
│  PostGIS (Geolocalisation)                           │
│  Redis (Cache)                                       │
└─────────────────────────────────────────────────────┘
```

### 4.2 Stack Technique

| Couche | Technologie | Version | Statut |
|--------|-------------|---------|--------|
| Frontend | HTML5, CSS3, Tailwind CSS (CDN) | 3.4+ | Implemente |
| JavaScript | Vanilla ES6+ | - | Implemente |
| Cartes | Leaflet.js + OpenStreetMap | 1.9+ | Implemente |
| Backend | Python, Flask | 3.11+, 3.0+ | Implemente (mode demo) |
| Auth backend | Flask-JWT-Extended | 4.6+ | Implemente |
| Rate limiting | Flask-Limiter | 3.5+ | Implemente |
| ORM | SQLAlchemy | 2.0+ | Modeles prets (pas encore branches) |
| Migrations | Alembic | 1.13+ | Migration 001 prete |
| Base de donnees | PostgreSQL + PostGIS | 15+ / 3.3+ | Docker prete, seeds prets |
| Cache | Redis | 7.0+ | Service Docker prete |
| Validation | Marshmallow | 3.0+ | Dependance installee |

## 5. Modele de Donnees

### 5.1 Entites Principales

```
departement (id, nom, code, created_at, updated_at)
  │
  ├── commune (id, departement_id, nom, code, created_at, updated_at)
  │     │
  │     ├── arrondissement (id, commune_id, nom, code, created_at, updated_at)
  │     │     │
  │     │     └── quartier (id, arrondissement_id, nom, code, created_at, updated_at)
  │     │
  │     └── centre_vote (id, commune_id, nom, adresse, latitude, longitude, type, capacite, created_at, updated_at)
  │           │
  │           └── bureau_vote (id, centre_vote_id, numero, nom, capacite, latitude, longitude, created_at, updated_at)
  │
  └── circonscription (id, departement_id, nom, type, created_at, updated_at)

electeur (id, nom, prenom, numero_inscription, numero_cni, date_naissance, sexe, adresse, quartier_id, bureau_vote_id, created_at, updated_at)

carte_identite (id, numero_cni [unique, 13 car.], nom, prenom, date_naissance, lieu_naissance, sexe, date_delivrance, date_expiration, actif, created_at, updated_at)

admin_user (id, username, email, password_hash, role, actif, created_at, last_login)

notification (id, titre, message, type, date_publication, date_expiration, active, created_at)

stats_recherche (id, date_recherche, type_recherche, zone, succes, duree_ms)
```

## 6. Endpoints API

Base URL : `/api/v1` — tous les endpoints ci-dessous sont **implementes** dans `backend/app.py`.

### 6.0 Sante et statistiques

| Methode | Endpoint | Description | Limite |
|---------|----------|-------------|--------|
| GET | /api/v1/health | Etat du service (mode demo) | exempt |
| GET | /api/v1/stats | Statistiques globales | exempt |

### 6.1 Recherche

| Methode | Endpoint | Description | Limite |
|---------|----------|-------------|--------|
| GET | /api/v1/recherche/electeur?q= | Rechercher un electeur (nom, prenom, numero) | 30/min |
| GET | /api/v1/recherche/centre?q= | Rechercher un centre de vote | 30/min |
| GET | /api/v1/recherche/geographique?commune= | Recherche geographique | 30/min |
| GET | /api/v1/suggestions?q= | Auto-completion (max 10) | 60/min |

### 6.2 Geolocalisation

| Methode | Endpoint | Description | Limite |
|---------|----------|-------------|--------|
| GET | /api/v1/centres?commune= | Liste des centres (avec coordonnees) | 30/min |
| GET | /api/v1/centres/{id} | Detail d'un centre (+ bureaux) | 60/min |
| GET | /api/v1/bureaux?centre_id= | Liste des bureaux (avec coordonnees) | 30/min |
| GET | /api/v1/proximite?lat=&lng=&radius= | Centres proches (Haversine, tri par distance) | 30/min |

### 6.3 Itineraire

| Methode | Endpoint | Description | Limite |
|---------|----------|-------------|--------|
| GET | /api/v1/itineraire?lat_depart=&lon_depart=&lat_arrivee=&lon_arrivee=&mode= | Distance, duree estimee et instructions (modes : marche, voiture, transport_commun) | 30/min |

### 6.4 Notifications

| Methode | Endpoint | Description | Limite |
|---------|----------|-------------|--------|
| GET | /api/v1/notifications | Liste des notifications actives | 60/min |

### 6.5 Inscription electorale

| Methode | Endpoint | Description | Limite |
|---------|----------|-------------|--------|
| POST | /api/v1/inscription | Inscrire un votant (validation CNI 13 car., anti-doublons) | 5/min |
| GET | /api/v1/inscription/verifier?q= | Verifier si un electeur est deja inscrit | 30/min |

### 6.6 Administration

| Methode | Endpoint | Description | Limite |
|---------|----------|-------------|--------|
| POST | /api/v1/admin/login | Connexion administrateur (JWT) | 10/min |
| GET | /api/v1/admin/dashboard | Statistiques (JWT) | 100/min |
| GET, POST | /api/v1/admin/centres | Liste / creation de centres (JWT) | 100/min |
| GET | /api/v1/admin/electeurs?search= | Liste / recherche d'electeurs (JWT) | 100/min |
| GET, POST | /api/v1/admin/notifications | Liste / creation de notifications (JWT) | 100/min |
| GET | /api/v1/admin/verifier-cni?numero= | Verification CNI : existence + deja utilise (JWT) | 100/min |
| GET | /api/v1/admin/electeurs-par-centre | Electeurs par centre pour la carte admin (JWT) | 100/min |

> Les blueprints modulaires de `backend/routes/` (recherche, geolocalisation, itineraire,
> notifications, admin) reproduisent ces memes routes cote SQLAlchemy et serviront de base
> au branchement PostgreSQL.

## 7. Securite

### 7.1 Authentification

- JWT access token (expire: 15 min)
- Refresh token (expire: 7 jours) - cible production (blueprint `routes/admin.py`)
- Stockage cote client : `localStorage` (`elect27_token`, `elect27_user`)
- Compte de demonstration : admin@elect27.cg / admin123 (a remplacer en production)

### 7.2 Autorisation

| Role | Permissions |
|------|-------------|
| admin | Lecture + Ecriture sur toutes les donnees |
| editor | Lecture + Ecriture sur les donnees electorales |
| viewer | Lecture seule |

### 7.3 Protection

- Rate limiting (Flask-Limiter, stockage memoire) :
  - 100 req/min par defaut (API publique)
  - 30 req/min sur les recherches, 60 req/min sur suggestions/notifications
  - 10 req/min sur login admin, **5 req/min sur l'inscription**
- CORS: en mode demo `origins=['*']` — a restreindre via `CORS_ORIGINS` avant production
- Input validation: cote serveur (longueur CNI = 13, champs requis, anti-doublons)
- SQL injection: parameterized queries via SQLAlchemy (phase PostgreSQL)
- XSS: Output encoding + CSP headers (cible production)

### 7.4 Validation de l'inscription (regles metier)

1. CNI : exactement 13 caracteres numeriques
2. CNI doit exister dans `cartes_identite` avec `actif = true`
3. CNI ne doit pas deja etre ratache a un electeur
4. Nom, prenom, date de naissance, sexe (M/F), adresse, commune, centre requis
5. Numero d'inscription genere automatiquement : `EC2027` + index sur 4 chiffres
6. Rejet (409) si nom+prenom deja presents dans la liste électorale
