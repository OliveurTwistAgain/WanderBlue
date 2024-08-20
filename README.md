# WanderBlue 🌊 (ce readme est en cours de rédaction -- dernière maj : lundi 19/08/24)

Bienvenue sur **WanderBlue** ! Un projet Ghost CMS personnalisé, propulsé par Docker et déployé en localhost puis via Railway 🚀.

## 📝 Description

WanderBlue est un blog moderne construit avec [Ghost](https://ghost.org/). Ce projet utilise Docker pour une portabilité maximale et est déployé via Railway pour une gestion simplifiée en lien avec ce repository. Il est également configuré pour utiliser une base de données MySQL 8 hébergée sur Filess.io (accessible publiquement).

## ⚙️ Fonctionnalités et structure

- ✨ **Ghost CMS** : Le cœur de la plateforme, offrant des fonctionnalités de blog puissantes.
- 🐳 **Docker** : Facilité de déploiement et de gestion grâce à la conteneurisation.
- 🛠️ **CI/CD avec GitHub Actions** : Déploiement en local et tests intermédiaires via GitHub Actions avant déploiement sur Railway.
- 🗄️ **MySQL 8** : Base de données, MySQL 8 requis avec l'image Ghost:latest.
- ✉️ **Intégration Mailgun** : Gère les emails transactionnels avec efficacité.
- 📝 **Structure** : arborescence typique de début de projet Ghost via Docker

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

- Docker Desktop installé 🐳
- Compte sur [Filess.io](https://filess.io) pour accès à une instance MySQL 8 💾
- Compte sur [Mailgun](https://www.mailgun.com/) pour les emails 📬
- Compte sur ? (quelque part, je cherche) pour le déploiement 🥁

Petit conseil : si vous êtes sur Visual Studio Code, ajouter les extensions suivantes : Git, GitHub Actions, Database et Docker. Très pratique !

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

   Seule `GHOST_URL`prendra une valeur différente dans les variables lors du déploiement à savoir `GHOST_URL=https://wanderblue.xxxx.app` (selon l'hébergeur choisi) ! Pour la clé API de Mailgun, la créer dans settings > API Keys sur Dashboard Mailgun. TEST_EMAIL te permet de recevoir les emails tests du Workflow GitHub Actions.

3. **Lancer avec Docker :**

   ```bash
   docker-compose up -d
   ```

4. **Accéder à Ghost :**

   Le Frontend sera accessible sur `http://localhost:2368`.
   Le Backend (ou Dashboard) sera accessible sur `http://localhost:2368/ghost`

   Et en production (selon l'hébergeur choisi) :

   Frontend : `https://wanderblue.xxx.app`
   Backend : `https://wanderblue.xxx.app/ghost`

5. **Tester le workflow via GitHub Actions :**

   Configurer tous les secrets sur GitHub Actions (voir plus haut) et RDV sur votre projet, rubrique Actions pour observer votre workflow de tests en 3 parties distinctes : Pipeline MySQL via Docker + Ghost en Local + Mailgun.

6. **Déploiement :**

   Créer un projet chez un hébergeur (recherche actuelle) en le connectant à ton dépôt GithHub. Vérifier les variables d'environnement, les mêmes que dans le fichier .env sauf $GHOST_URL ! Ce n'est plus `http://localhost:2368` mais l'URL xxx `https://wanderblue.xxx.app` !

---

📝 **Note** : Ce projet est en cours de développement.
Phase 1 : install localhost = 100%
Phase 2 : Tests CICD = 100%
Phase 3 : déploiement non ok pour le moment, j'ai testé d'abord Render, puis Railway, je ne suis pas loin mais ça coince (problème d'accès à la base de données sur Render et erreur 404 sur Vercel)... Je vais tester Railway App qui me semble intéressant et je mettrai à jour ce README.md en fonction... 🤞

Merci de votre patience et éventuellement de vos retours constructifs | 📬 Email : oliveur.twist.again[at]proton.me
