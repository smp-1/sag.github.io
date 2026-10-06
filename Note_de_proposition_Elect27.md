# NOTE DE PROPOSITION

---

**À l'attention de :** Monsieur le Ministre de l'Intérieur — **Ministère de l'Intérieur de la République du Congo**

**De :** [Porteur du projet / Cellule de conception Elect27]

**Date :** [à préciser]

**Objet :** Proposition de mise en œuvre du projet **Elect27** — application web de localisation des lieux de vote, initiative d'intérêt général **à caractère strictement non commercial**, en vue des élections législatives et locales de 2027 en République du Congo.

**Réf. dossier :** Spécifications techniques v1.1, Backlog projet, Cahier des charges, Présentation Elect27

---

## 1. Objet de la note

La présente note propose au **Ministère de l'Intérieur** de retenir le projet **Elect27** comme outil d'appui à l'information et à la mobilité des électeurs pour le cycle électoral 2027, et d'accorder son appui institutionnel et/ou son financement à son déploiement.

Elect27 n'est **pas un projet commercial** : il ne poursuit aucun objectif de lucrativité, ne monétise ni les données des électeurs, ni l'accès des citoyens au service. Il s'agit d'une infrastructure numérique d'intérêt général, proposée **gratuitement** aux citoyens, dont les besoins de couverture (hébergement, sensibilisation, mise à jour des données) doivent être couverts par des subventions, un partenariat public ou des contributions volontaires.

## 2. Contexte et problématique

Les élections de 2027 mobiliseront plusieurs millions d'électeurs sur l'ensemble du territoire national. Or, l'accès à une information fiable sur le **lieu de vote** reste un point de friction :

- **Fragmentation de l'information** : les listes d'inscription et la répartition des centres/bureaux ne sont pas toujours accessibles sous forme numérique, actualisée et interrogeable par le citoyen lui-même ;
- **Erreurs et déplacements inutiles** : un électeur non informé de son affectation se présente au mauvais bureau, ou renonce à voter ;
- **Faiblesse de la couverture numérique** : l'information électorale reste souvent portée par des canaux physiques (affichage, presse), peu adaptés aux usages mobiles ;
- **Charge pour les administrateurs** : la gestion des inscriptions, des doublons de cartes d'identité et des affectations reste largement manuelle.

**Conséquence directe** : désorganisation le jour du scrutin, temps d'attente accru, frustration des électeurs et risque d'abstention par défaut.

## 3. La proposition : la plateforme Elect27

Elect27 est une **application web responsive mobile-first** (320 px → 2560 px), accessible (cible WCAG 2.1 AA), permettant à chaque citoyen de :

| N° | Fonctionnalité | Bénéfice citoyen |
|----|----------------|------------------|
| 1 | **Recherche du lieu de vote** (nom, numéro d'inscription, adresse, filtres géographiques, auto-complétion) | Trouver son bureau en moins d'une seconde |
| 2 | **Carte interactive** des centres et bureaux (Leaflet + OpenStreetMap, géolocalisation) | Voir visuellement son lieu de vote et les plus proches |
| 3 | **Itinéraire** (marche, voiture, transport en commun ; distance et durée estimées) | Savoir comment s'y rendre et en combien de temps |
| 4 | **Inscription électorale en 3 étapes** avec **vérification du n° de CNI (13 caractères)** et anti-doublon | S'inscrire de façon fiable, sans double inscription |
| 5 | **Vérification d'inscription préalable** | Savoir en un instant si l'on est déjà inscrit |
| 6 | **Notifications électorales** (dates importantes, alertes de modification de bureau) | Ne manquer aucune information décisive |
| 7 | **Back-office d'administration** (statistiques, gestion des centres/électeurs, carte des centres colorée par affluence) | Piloter la registration en temps réel |

**Stack technique** : HTML5/CSS3/Tailwind/JavaScript — Leaflet/OpenStreetMap — Python 3.11+/Flask (JWT, CORS, rate limiting) — PostgreSQL 15+/PostGIS — Redis — Docker/Nginx. Architecture éprouvée, standardisée, sans dépendance à un service commercial propriétaire.

## 4. Nature non commerciale du projet — engagements

Le projet est déclaré **non commercial** et s'engage aux principes suivants :

1. **Gratuité absolue pour les citoyens** : aucun abonnement, aucun frein à l'accès, aucune publicité ;
2. **Aucune monétisation des données** : les données d'identification et d'inscription ne sont ni revendues, ni exploitées à des fins publicitaires ou commerciales ;
3. **Financement non commercial** : les coûts de fonctionnement (hébergement, nom de domaine, campagnes de sensibilisation, mise à jour des référentiels) sont couverts par subventions, partenariat institutionnel ou contributions volontaires — jamais par la facturation des usagers ;
4. **Souveraineté et transparence** : code documenté, architecture ouverte, exploitable par un opérateur public sans verrouillage propriétaire ;
5. **Conformité** : traitement des données personnelles encadré, finalité limitée à l'information électorale, sécurisation (HTTPS/TLS 1.3, bcrypt, JWT, rate limiting) ;
6. **Neutralité** : l'outil est un service d'information, sans affiliation politique ni effet de propagande.

## 5. État d'avancement et faisabilité

| Phase | Statut |
|-------|--------|
| Spécifications, backlog, architecture | ✅ Terminé (spécifications v1.1) |
| Frontend (recherche, carte, inscription, admin) | ✅ Livré |
| Backend API Flask (recherche, géolocalisation, itinéraire, notifications, inscription, admin) | ✅ Livré |
| Base de données (11 tables, migrations, seeds) | ✅ Prêt (bascule PostgreSQL à effectuer) |
| Documentation + présentation | ✅ Livré |
| **Tests unitaires / intégration** | 🔄 En cours |
| Sécurisation (CORS restrictif, hashing, HTTPS) | ⏳ Pré-requis de mise en production |
| Déploiement pilote | ⏳ À venir |

**Indicateurs techniques visés** : chargement < 3 s, réponse API < 500 ms, recherche < 1 s, disponibilité 99,5 %, conformité WCAG 2.1 AA.

**Faisabilité** : le développement est **terminé et documenté** ; le passage du mode démonstration à la production consiste uniquement à brancher l'existant sur PostgreSQL/PostGIS (migrations et données initiales déjà produites). Le projet est donc à faible risque techniquement et maîtrisé en coût.

## 6. Bénéficiaires et impact attendu

- **Citoyens électeurs** : information fiable, immédiate et gratuite sur leur lieu de vote, réduction des erreurs d'affectation et des déplacements inutiles ;
- **Autorité organisatrice / services électoraux** : outil de pilotage des inscriptions (anti-doublon CNI, statistiques par centre, carte d'affluence) ;
- **Organisation du scrutin** : fluidification du jour J, moins de litiges d'inscription, meilleure couverture médiatique de l'information officielle ;
- **Société civile et médias** : canal citoyen neutre de diffusion de l'information électorale.

## 7. Calendrier de mise en œuvre (feuille de route)

| Étape | Contenu | Horizon indicatif |
|-------|---------|-------------------|
| 1 | Clôture des tests (unitaires, intégration, E2E) | Immédiat |
| 2 | Bascule PostgreSQL/PostGIS + durcissement sécurité (CORS, HTTPS, hashing) | Phase pilote |
| 3 | Alimentation des référentiels officiels (centres, bureaux, listes) avec l'autorité compétente | Pré-campagne |
| 4 | Déploiement pilote sur une ou deux localités + recueil de retours | [à préciser] |
| 5 | Déploiement national + campagne multicanale d'information des électeurs | Campagne 2027 |
| 6 | Suivi-évaluation et maintenance pendant la période électorale | Jusqu'au scrutin |

## 8. Besoins d'accompagnement (hors logique commerciale)

Aucun retour sur investissement n'est recherché. Les besoins exprimés sont ceux d'une **infrastructure d'intérêt général** :

| Besoin | Nature |
|--------|--------|
| Hébergement serveur + nom de domaine (2026-2027) | Financement / partenariat technique |
| Mise à disposition des données officielles (centres, bureaux, listes) | Appui institutionnel |
| Campagne d'information et de sensibilisation des électeurs | Partenariat / mécénat |
| Maintenance et support pendant la période électorale | Ressources humaines |
| Éventuelle adaptation (offline léger, USSD/SMS, multilingue) | Évolution de périmètre |

## 9. Indicateurs de suivi

- Nombre de centres et bureaux de vote référencés (cible : couverture nationale) ;
- Nombre de recherches d'itinéraire et de vérifications d'inscription ;
- Taux de disponibilité de la plateforme (cible 99,5 %) ;
- Nombre d'inscriptions validées sans doublon ;
- Nombre de notifications diffusées et taux de lecture ;
- Accessibilité conforme WCAG 2.1 AA.

## 10. Risques majeurs et mesures d'atténuation

| Risque | Mesure d'atténuation |
|--------|----------------------|
| Données officielles incomplètes ou non transmises | Engagement d'interlocuteur unique + calendrier d'alimentation dès la phase pilote |
| Connectivité limitée / usages sur mobile bas de gamme | Application légère (front statique, cache Redis), cible 3G, optimisation images |
| Attaques ou tentatives de fraude (inscription) | Vérification CNI 13 car. + anti-doublon + rate limiting + JWT + HTTPS |
| Protection des données personnelles | Finalité unique, accès restreint (JWT), pas d'exploitation commerciale, Closer |
| Perte de confiance / perception politique | Neutralité affichée, transparence du code, communication factuelle |
| Panne au moment critique | Disponibilité 99,5 %, déploiement conteneurisé (Docker), plan de secours |

## 11. Conclusion et demande

Le projet Elect27 est **conçu, développé et documenté** ; il reste à le tester, le sécuriser, l'alimenter en données officielles et le déployer. Sa nature **non commerciale** le rend directement adossable à une logique d'intérêt général : aucun bénéfice privé n'est recherché, seul l'intérêt des électeurs et la qualité de l'organisation électorale sont servis.

**Il est demandé au Ministère de l'Intérieur :**

1. De **retenir** Elect27 comme proposition d'outil d'appui au cycle électoral 2027 ;
2. D'**appuyer** son déploiement (appui institutionnel, mise à disposition des données, partenariat ou financement de l'hébergement et de la sensibilisation) ;
3. D'**désigner un interlocuteur** pour engager la phase pilote dans les meilleurs délais.

---

**Pièces jointes au dossier**

1. Fiche projet résumée (1 page)
2. Spécifications techniques v1.1 (fonctionnel / non fonctionnel)
3. Backlog projet (user stories par épique)
4. Cahier des charges Elect27
5. Présentation Elect27 (Pitch deck)
6. Feuille de route de mise en œuvre

---

*Note de proposition — Projet Elect27 — Initiative non commerciale d'intérêt général — République du Congo, élections 2027*
