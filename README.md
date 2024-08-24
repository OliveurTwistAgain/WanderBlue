# WanderBlue 🌊

Bienvenue sur **WanderBlue** ! Flâner et trouver... votre coin de ciel bleu !

Un projet Ghost CMS personnalisé, propulsé par Docker et déployé en localhost puis via Railway 🚀. L'idée est de proposer aux internautes des idées de visites à travers le monde via un formulaire de recherche (ville à saisir). Chaque post est un lieu avec coordonnées GPS latitude et longitude.

## 📝 Description

WanderBlue est construit avec [Ghost](https://ghost.org/). Ce projet utilise Docker pour une portabilité maximale et est déployé en premier lieu en localhost avec une base de données MySQL 8 hébergée sur Filess.io puis propulsé par Railway (https://wanderblue-template.up.railway.app).

## ⚙️ Fonctionnalités et structure

- ✨ **Ghost CMS** : Le cœur de la plateforme, offrant des fonctionnalités puissantes, création d'API comprises.
- 🐳 **Docker** : Facilité de déploiement et de gestion grâce à la conteneurisation.
- 🛠️ **CI/CD avec GitHub Actions** : Déploiement en local et tests intermédiaires via GitHub Actions avant déploiement sur Railway.
- 🗄️ **MySQL 8** : Base de données, MySQL 8 requis avec l'image Ghost:latest.
- ✉️ **Intégration Mailgun** : Gère les emails transactionnels avec efficacité.
- 📝 **Structure** : Arborescence typique de début de projet Ghost via Docker

```
WanderBlue/
│
├── content/              # Contient les thèmes, images, et autres contenus statiques
│   ├── themes/           # Vos thèmes Ghost personnalisés
│   └── images/           # Vos images et médias
├── docker-compose.yml    # Fichier Docker Compose si vous utilisez plusieurs services
├── Dockerfile            # Fichier Docker pour la configuration du conteneur
└── .env                  # Variables d'environnement pour la configuration
```

## 🚀 Déploiement en Local puis sur Railway

### Prérequis

- Compte sur [Filess.io](https://filess.io) pour accès à une instance MySQL 8 💾
- Compte sur [Mailgun](https://www.mailgun.com/) pour les emails 📬
- Compte sur [Railway](https://railway.app/) pour le déploiement 🥁

Petit conseil : si vous êtes sur Visual Studio Code, ajouter les extensions suivantes : Git, GitHub Actions, Database !

### Instructions

1. **Cloner le dépôt :**

   ```bash
   git clone https://github.com/OliveurTwistAgain/WanderBlue.git
   cd WanderBlue
   ```

2. **Configurer les Variables d'Environnement :**

   Assurez-vous que vos secrets sont configurés correctement dans GitHub Actions, dans votre fichier `.env` et dans votre Dashboard Railway (settings). Nommer toutes vos variables de manière identique pour une meilleure gestion. Exemple pour ce projet :

   ```
   DATABASE_CLIENT=mysql
   DATABASE_HOST=mysql-host-filess.io_db
   DATABASE_NAME=nom_db
   DATABASE_USER=nom_user_db
   DATABASE_PASSWORD=password_db
   DATABASE_PORT=port_db
   GHOST_URL=http://localhost:2368
   GHOST_PORT=2368
   MAIL_TRANSPORT=SMTP
   MAIL_SERVICE=Mailgun
   MAIL_USER=postmaster@sandbox.xxx.mailgun.org
   MAIL_FROM=bob@sandbox.xxx.mailgun.org
   MAIL_PASSWORD=password_mailgun
   MAILGUN_API_KEY=api-key-mailgun
   MAILGUN_DOMAIN=sandbox.xxx.mailgun.org
   TEST_EMAIL=ton_adresse_email_habituelle@xxx.com
   ```

   Seule `GHOST_URL`prendra une valeur différente dans les variables lors du déploiement à savoir `GHOST_URL=https://xxxx.railway.app`. Pour la clé API de Mailgun, la créer dans settings > API Keys sur Dashboard Mailgun. TEST_EMAIL permet de recevoir les emails tests du Workflow GitHub Actions.

3. **Lancer avec Docker :**

   ```bash
   docker-compose up -d
   ```

4. **Accéder à Ghost :**

   Le Frontend sera accessible sur `http://localhost:2368`.
   Le Backend (ou Dashboard) sera accessible sur `http://localhost:2368/ghost`

   Et en production :

   Frontend : `https://xxx.railway.app`
   Backend : `https://xxx.railway.app/ghost`

5. **Tester le workflow via GitHub Actions :**

   Configurer tous les secrets sur GitHub Actions. Go sur votre projet, rubrique Actions pour observer votre workflow de tests (CICD.yml) en 3 parties distinctes : Pipeline MySQL via Docker + Ghost en Local + Mailgun.

6. **Déploiement :**

   Créer un projet chez un hébergeur. Vérifier les variables d'environnement, les mêmes que dans le fichier .env sauf $GHOST_URL ! Ce n'est plus `http://localhost:2368` !

---

📝 **Note** :
Phase 1 : install localhost = 100%
Phase 2 : Tests CICD = 100%
Phase 3 : déploiement Railway = 100%

NB : pour le déploiement, j'avais deux choix possibles. Option 1/ Ghost depuis le repository avec les difficultés d'accès à la base de données MySQL depuis l'extérieur (j'ai essayé Render avec Filess.io, échec, accès refusé à la BDD ; j'imagine que la gratuité a ses limites). Option 2/ Ghost depuis un conteneur Docker et une base de données MySQL 8 hébergé sur Railway. Pour des raisons de timing et de tranquilité, j'ai choisi la deuxième solution avec le Hobby Plan de Railway (5$ par mois).

👨‍💻 **Contact** | 📬 Email : oliveur.twist.again[at]proton.me

{{!-- Dernier dépôt le 24/08/2024 : thème Ghost modifié et adapté aux besoins de la homepage, formulaire de recherche et carte Leaflet. --}}
