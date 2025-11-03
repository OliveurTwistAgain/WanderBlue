# WanderBlue

Bienvenue sur WanderBlue ! Flânez et trouvez votre coin de ciel bleu

Un projet Ghost CMS personnalisé, propulsé par Docker. L’objectif du site web ? Proposer aux internautes des idées de visites à travers le monde via un formulaire de recherche (ville à saisir). Chaque post représente un lieu avec ses coordonnées GPS (latitude et longitude).

## Configuration

Ce projet permet de lancer une instance **Ghost CMS** en local avec **Docker** et une base **SQLite**.  
C’est une configuration pour tester, développer et comprendre Ghost avant de déployer en production.

## Prérequis

- [Docker](https://www.docker.com/get-started) installé sur ta machine
- [VS Code](https://code.visualstudio.com/) (recommandé)
- Un terminal (ex. PowerShell sous Windows)

## Installation

### 1. Clone du projet

```bash
git clone https://github.com/OliveurTwistAgain/WanderBlue.git
cd WanderBlue
```

### 2. Variables d’environnement

Créer un fichier **`.env`** à la racine avec ce contenu :

```bash
# Ghost - Localhost
GHOST_URL=http://localhost:2368
GHOST_PORT=2368

# SQLite (base locale)
DATABASE_CLIENT=sqlite3
DATABASE_FILE=content/data/ghost.db

# Mail (optionnel, pour tests via Mailgun sandbox)
MAIL_TRANSPORT=SMTP
MAIL_SERVICE=Mailgun
MAIL_USER=postmaster@sandbox.mailgun.org
MAIL_PASSWORD=password
MAIL_FROM="Ghost Local <no-reply@localhost>"
MAILGUN_API_KEY=api-key
MAILGUN_DOMAIN=sandbox.mailgun.org
```

Et pour un déploiement production, créer un fichier .env.prod (exemple sur Render, Railway, DigitalPress etc) :

```bash
GHOST_URL=https://ton-projet.onrender.com
PORT=2368
DATABASE_CLIENT=sqlite3
DATABASE_FILE=./content/data/ghost.db
NODE_ENV=production
```

### 3. Exemple de docker-compose.yml

À créer à la racine :

```yaml
services:
  ghost:
    image: ghost:latest
    ports:
      - "${GHOST_PORT:-2368}:2368"
    environment:
      database__client: "${DATABASE_CLIENT}"
      database__connection__filename: "${DATABASE_FILE}"
      url: "${GHOST_URL}"
    volumes:
      - ./content:/var/lib/ghost/content
```

Les données Ghost (base SQLite, images, thèmes, etc.) sont persistées localement dans le dossier ./content.

## Commandes utiles

```bash
# Démarrer Ghost en local
docker compose up -d

# Arrêter Ghost
docker compose down

# Démarrer Ghost en production
docker compose --env-file .env.prod up -d

# Voir les logs en temps réel
docker compose logs -f

# Redémarrer après modification du .env
docker compose down && docker compose up -d

# Lister les conteneurs actifs
docker ps

# Supprimer les volumes (utile uniquement pour repartir à zéro)
docker compose down -v

# Générer la structure du projet sur Windows
tree /f > structure.txt

# sur macOS / Linux
tree -a > structure.txt
```

## Accès

- **Admin** : [http://localhost:2368/ghost](http://localhost:2368/ghost)
- **Site public** : [http://localhost:2368](http://localhost:2368)

## Étapes suivantes

- Ajouter des articles/pages dans Ghost
- Explorer l’API Content : `/ghost/api/content/`
- Tester l’API Admin : `/ghost/api/admin/`
- Préparer un déploiement en production : Railway, Render, Pikapods, DigitalPress, VPS…
- Tester une approche _headless CMS_ (Ghost en backend) avec un frontend Gatsby ou Next.js déployé sur Netlify/Vercel.

## Contact

📬 Email : oliveur.twist.again[at]proton.me
