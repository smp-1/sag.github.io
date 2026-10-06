# Backlog - Elect27 Web App

> **Mise a jour (Septembre 2026) :** developpement termine, phase de tests en cours (`test-001`).
> Statuts : `[x]` implemente et livre, `[~]` partiel / a completer en test, `[ ]` non fait / a venir.

## Priorites

| Priorite | Definition |
|----------|------------|
| P0 | Must-have - bloquant pour le lancement |
| P1 | Should-have - important pour l'experience |
| P2 | Nice-to-have - amelioration future |

---

## Epic 1: Recherche de Lieu de Vote

### US-1.1: Recherche par informations personnelles
**Priorite:** P0 — **Statut:** livre
**En tant que** citoyen  
**Je veux** rechercher mon lieu de vote en saisissant mon nom ou numero d'inscription  
**Afin de** trouver rapidement mon centre et bureau de vote  
**Criteres d'acceptation:**
- [x] Champ de recherche principal visible sur la page d'accueil
- [x] Recherche par nom (tolerance aux fautes de frappe - recherche partielle case-insensitive)
- [x] Recherche par numero d'inscription electorale
- [ ] Affichage des resultats en moins de 1 seconde (a valider en tests)
- [x] Message clair si aucun resultat trouve
- [x] Responsive mobile

### US-1.2: Recherche geographique
**Priorite:** P0 — **Statut:** livre (filtres simplifies)
**En tant que** citoyen  
**Je veux** rechercher par departement, commune, quartier  
**Afin de** identifier les lieux de vote dans ma zone  
**Criteres d'acceptation:**
- [~] Filtres cascades (Departement > Commune > Arrondissement > Quartier) — Commune + Departement actifs
- [x] Dropdowns dynamiques
- [x] Mise a jour des resultats en temps reel
- [x] Affichage sur carte simultanee (page recherche.html)

### US-1.3: Auto-completion
**Priorite:** P1 — **Statut:** livre
**En tant que** citoyen  
**Je veux** des suggestions pendant que je tape  
**Afin de** saisir plus rapidement et avec moins d'erreurs  
**Criteres d'acceptation:**
- [x] Suggestions apres 2 caracteres
- [x] Max 10 suggestions affichees
- [x] Navigation clavier dans les suggestions
- [x] Debounce de 300ms

---

## Epic 2: Geocalisation

### US-2.1: Affichage sur carte
**Priorite:** P0 — **Statut:** livre
**En tant que** citoyen  
**Je veux** voir les lieux de vote sur une carte interactive  
**Afin de** visualiser leur localisation exacte  
**Criteres d'acceptation:**
- [x] Carte Leaflet.js integree
- [x] Marqueurs pour chaque lieu de vote
- [x] Popups avec informations du lieu
- [x] Zoom et deplacement libres
- [ ] Fallback image si pas de GPS (a valider en tests)

### US-2.2: Ma position
**Priorite:** P1 — **Statut:** livre
**En tant que** citoyen  
**Je veux** que l'application detecte ma position  
**Afin de** trouver le lieu de vote le plus proche  
**Criteres d'acceptation:**
- [x] Demande de permission GPS
- [x] Centrage de la carte sur ma position
- [x] Affichage du lieu le plus proche (endpoint /proximite, distance Haversine)
- [x] Gestion du refus de permission
- [x] Fallback manuel (saisie adresse)

### US-2.3: Details du lieu
**Priorite:** P0 — **Statut:** livre
**En tant que** citoyen  
**Je veux** voir les details d'un lieu de vote  
**Afin de** connaitre l'adresse exacte et les informations pratiques  
**Criteres d'acceptation:**
- [x] Nom du centre/bureau
- [x] Adresse complete
- [x] Horaires d'ouverture
- [x] Capacite
- [ ] Photo du lieu (optionnel, non prioritaire)

---

## Epic 3: Itineraire

### US-3.1: Calcul d'itineraire
**Priorite:** P1 — **Statut:** livre (estimation)
**En tant que** citoyen  
**Je veux** obtenir l'itineraire depuis ma position vers le lieu de vote  
**Afin de** savoir comment s'y rendre  
**Criteres d'acceptation:**
- [x] Itineraire affiche sur la carte
- [x] Distance et duree estimee
- [x] Instructions pas a pas
- [x] Mode marche par defaut

> **TODO / ecart:** `carte.html` pointe vers `itineraire.html` qui n'existe pas —
> a corriger (redirection vers carte.html + panneau itineraire, ou creer la page).

### US-3.2: Modes de transport
**Priorite:** P2 — **Statut:** livre
**En tant que** citoyen  
**Je veux** choisir le mode de transport  
**Afin d'**adapter l'itineraire a mes besoins  
**Criteres d'acceptation:**
- [x] Marche, voiture, transport en commun
- [x] Mise a jour de l'itineraire selon le mode
- [x] Icons pour chaque mode

---

## Epic 4: Notifications

### US-4.1: Notifications electorales
**Priorite:** P1 — **Statut:** livre (in-app)
**En tant que** citoyen  
**Je veux** recevoir des notifications sur les informations importantes  
**Afin de** ne rien manquer du processus electoral  
**Criteres d'acceptation:**
- [ ] Notifications push (si supporte) — non implemente
- [x] Fallback: notifications in-app
- [x] Liste des notifications consultable (accueil + endpoint /notifications)
- [ ] Marquer comme lu (a completer)

### US-4.2: Alertes de modification
**Priorite:** P0 — **Statut:** partiel
**En tant que** citoyen  
**Je veux** etre alerte si mon bureau de vote change  
**Afin de** ne pas me rendre au mauvais endroit  
**Criteres d'acceptation:**
- [ ] Notification si changement de bureau (admin peut publier une notif type alerte)
- [ ] Nouveau bureau affiche clairement
- [ ] Possibilite de recevoir par email

---

## Epic 5: Administration

### US-5.1: Dashboard admin
**Priorite:** P0 — **Statut:** livre
**En tant qu'** administrateur  
**Je veux** une vue d'ensemble des statistiques  
**Afin de** suivre l'utilisation de l'application  
**Criteres d'acceptation:**
- [x] Nombre de recherches par jour (stats endpoint)
- [x] Centres les plus consultes
- [x] Zones geographiques les plus actives
- [ ] Graphiques interactifs (Chart.js — a valider en tests)
- [ ] Export CSV (a venir)

### US-5.1b: Carte des electeurs par centre (nouveau)
**Priorite:** P1 — **Statut:** livre
**En tant qu'** administrateur  
**Je veux** visualiser sur une carte le nombre d'electeurs inscrits par centre  
**Afin de** repartir equitativement les bureaux de vote  
**Criteres d'acceptation:**
- [x] Onglet carte dans le dashboard admin
- [x] Marqueurs dimensionnes / colores selon le nombre d'electeurs
- [x] Endpoint `/admin/electeurs-par-centre`

### US-5.2: Gestion des centres
**Priorite:** P0 — **Statut:** livre
**En tant qu'** administrateur  
**Je veux** ajouter, modifier, supprimer des centres de vote  
**Afin de** maintenir les donnees a jour  
**Criteres d'acceptation:**
- [x] Formulaire de creation/edition
- [x] Validation des donnees
- [x] Suppression avec confirmation
- [x] Recherche et filtrage
- [ ] Pagination (a completer)

### US-5.3: Gestion des bureaux
**Priorite:** P0 — **Statut:** partiel (via centre)
**En tant qu'** administrateur  
**Je veux** gerer les bureaux de vote associes aux centres  
**Afin de** maintenir la hierarchie des lieux  
**Criteres d'acceptation:**
- [x] Liaison centre-bureau
- [x] Gestion des capacites
- [x] Coordonnees GPS
- [ ] Import CSV/Excel (a venir)

### US-5.4: Gestion des electeurs
**Priorite:** P1 — **Statut:** partiel
**En tant qu'** administrateur  
**Je veux** importer et gerer les listes electorales  
**Afin de** maintenir la base de donnees electorale  
**Criteres d'acceptation:**
- [ ] Import CSV/Excel (a venir)
- [x] Validation des donnees
- [x] Gestion des doublons (verification CNI / nom-prenom)
- [x] Affectation aux bureaux

### US-5.5: Publication d'informations
**Priorite:** P1 — **Statut:** partiel
**En tant qu'** administrateur  
**Je veux** publier des informations electorales  
**Afin d'** informer les citoyens  
**Criteres d'acceptation:**
- [ ] Editeur de contenu complet (formulaire simple actuel)
- [ ] Planification de publication
- [x] Brouillon/publie (champ active)
- [x] Notification associee

### US-5.6: Authentification admin
**Priorite:** P0 — **Statut:** livre
**En tant qu'** administrateur  
**Je veux** me connecter de facon securisee  
**Afin d'** acceder au dashboard  
**Criteres d'acceptation:**
- [x] Page de connexion securisee (login dans admin/index.html)
- [x] JWT (access 15 min ; refresh token dans routes/admin.py)
- [x] Deconnexion (clear token)
- [~] Protection brute force (rate limiting 10 req/min login)

---

## Epic 6: Design et Accessibilite

### US-6.1: Design responsive
**Priorite:** P0 — **Statut:** livre
**En tant qu'** utilisateur  
**Je veux** utiliser l'application sur tous mes appareils  
**Afin d'** y acceder partout  
**Criteres d'acceptation:**
- [x] Mobile-first
- [x] Breakpoints: 320px, 640px, 768px, 1024px, 1280px
- [x] Navigation adaptee (hamburger sur mobile)
- [x] Touch targets min 44x44px

### US-6.2: Accessibilite
**Priorite:** P1 — **Statut:** livre (cible AA)
**En tant que** personne a mobilite reduite  
**Je veux** naviguer avec un lecteur d'ecran  
**Afin d'** utiliser l'application  
**Criteres d'acceptation:**
- [x] ARIA labels sur tous les elements interactifs
- [x] Navigation clavier complete
- [x] Contraste 4.5:1 minimum
- [x] Focus visible

---

## Epic 7: Inscription Electorale (ajout v1.1)

### US-7.1: Verification du numero CNI
**Priorite:** P0 — **Statut:** livre
**En tant que** citoyen  
**Je veux** verifier que mon numero CNI figure dans la liste électorale  
**Afin de** confirmer mon eligibilite avant de m'inscrire  
**Criteres d'acceptation:**
- [x] Champ CNI (13 caracteres numeriques) avec validation
- [x] Verification en temps reel via `/admin/verifier-cni` et `/inscription/verifier`
- [x] Message d'erreur clair si CNI inconnu ou deja utilise

### US-7.2: Formulaire d'inscription en 3 etapes
**Priorite:** P0 — **Statut:** livre
**En tant que** citoyen  
**Je veux** m'inscrire en suivant un parcours en 3 etapes  
**Afin de** ne pas etre decourage par un formulaire unique trop long  
**Criteres d'acceptation:**
- [x] Etape 1 : Informations personnelles (nom, prenom, date naissance, sexe, CNI, adresse)
- [x] Etape 2 : Choix du centre de vote (liste + recherche)
- [x] Etape 3 : Verification et confirmation
- [x] Navigation precedente/suivante avec validation a chaque etape
- [x] Barre de progression des etapes

### US-7.3: Confirmation et anti-doublons
**Priorite:** P0 — **Statut:** livre
**En tant que** citoyen  
**Je veux** recevoir mon numero d'inscription une fois l'ecran de confirmation affiche  
**Afin de** pouvoir prouver mon inscription  
**Criteres d'acceptation:**
- [x] Numero d'inscription genere (`EC2027XXXX`)
- [x] Anti-doublon CNI (409 si deja utilise)
- [x] Anti-doublon identite (nom + prenom)
- [x] Ecran de confirmation avec centre attribue

### US-7.4: Verification d'inscription prealable
**Priorite:** P0 — **Statut:** livre
**En tant que** citoyen  
**Je veux** verifier si je suis deja inscrit avant de remplir le formulaire  
**Afin de** gagner du temps  
**Criteres d'acceptation:**
- [x] Formulaire compact (nom + prenom ou numero + CNI)
- [x] Reponse : deja inscrit (affichage fiche) ou non inscrit (lien vers inscription)
- [x] Endpoint `/inscription/verifier`

---

## Estimation des Points de Story

| Epic | Stories | Points estimes | Statut global |
|------|---------|----------------|---------------|
| 1. Recherche | 3 | 13 | Livre |
| 2. Geocalisation | 3 | 15 | Livre |
| 3. Itineraire | 2 | 8 | Livre (TODO itineraire.html) |
| 4. Notifications | 2 | 8 | Partiel |
| 5. Administration | 7 (dont 5.1b) | 30 | Livre / partiel |
| 6. Design/Accessibilite | 2 | 8 | Livre |
| 7. Inscription CNI | 4 | 16 | Livre |
| **Total** | **23** | **98** | **Dev termine, tests en cours** |

## Ordre de Realisation

### Sprint 1 (Foundation) — termine
- [x] US-5.6: Authentification admin
- [x] US-6.1: Design responsive
- [x] US-2.1: Affichage sur carte
- [x] US-1.1: Recherche par informations personnelles

### Sprint 2 (Core Features) — termine
- [x] US-1.2: Recherche geographique
- [x] US-2.2: Ma position
- [x] US-2.3: Details du lieu
- [~] US-4.2: Alertes de modification

### Sprint 3 (Enhancement) — termine
- [x] US-1.3: Auto-completion
- [x] US-3.1: Calcul d'itineraire
- [x] US-4.1: Notifications electorales
- [x] US-6.2: Accessibilite

### Sprint 4 (Admin + Inscription) — termine
- [x] US-5.1: Dashboard admin
- [x] US-5.1b: Carte electeurs par centre
- [x] US-5.2: Gestion des centres
- [x] US-5.3: Gestion des bureaux
- [x] US-7.1 a US-7.4: Inscription electorale CNI

### Sprint 5 (Polish) — en cours (tests)
- [ ] US-5.4: Gestion des electeurs (import CSV)
- [ ] US-5.5: Publication d'informations (editeur complet)
- [ ] US-3.2: Modes de transport (livre, a tester)
- [ ] Correction TODO : page `itineraire.html` manquante
