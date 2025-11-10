# WanderBlue

Bienvenue sur WanderBlue ! Flânez et trouvez votre coin de ciel bleu...

Un projet Ghost CMS personnalisé, propulsé par Docker. L’objectif du site web ? Proposer aux internautes des idées de visites à travers le monde via un formulaire de recherche (ville à saisir). Chaque post représente un lieu avec ses coordonnées GPS (latitude et longitude). Ou comment créer, apprendre, réviser sa géographie et partager quelques fragments du monde en même temps !

![Carte Leaflet WanderBlue](<content/images/WanderBlue-Glasgow.png>)

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

Les fichiers .env et .env.prod ne contiennent aucune clé API sensible : les variables d’accès à l’API Ghost sont désormais injectées directement dans l’interface d’administration, via Settings → Code Injection.

Créer un fichier **`.env`** à la racine avec ce contenu :

```bash
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

Et pour un déploiement production, créer un fichier .env.prod à adapter selon ton environnement de production (exemple sur Render, Railway, DigitalPress etc) :

```bash
GHOST_URL=https://ton-projet.com
PORT=2368
DATABASE_CLIENT=sqlite3
DATABASE_FILE=./content/data/ghost.db
NODE_ENV=production
```

#### Configuration de la recherche (API Ghost)

Le thème **WanderBlue** utilise l’API publique de Ghost pour charger les lieux et leurs coordonnées GPS. Par sécurité, la clé d’API est injectée depuis l’interface d’administration Ghost.

En local, aller dans **Settings → Code Injection → Site Footer** puis ajouter :

```html
<script>
window.GHOST_API_URL = "http://localhost:2368/ghost/api/content/posts/";
window.GHOST_API_KEY = "votre_clef_api_locale";
</script>
```

En production, aller dans **Settings → Code Injection → Site Footer** puis ajouter :

```html
<script>
window.GHOST_API_URL = "https://ton-projet.com/ghost/api/content/posts/";
window.GHOST_API_KEY = "votre_clef_api_production";
</script>
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

### 4. Commandes utiles

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

# Générer la structure du projet sur Windows avec fichier texte
tree /f > structure.txt

# sur macOS / Linux avec fichier texte
tree -a > structure.txt

# sur macOS / Linux avec profondeur 2 sans fichier texte
tree -a -L 2 
```

### 5. Accès

- **Admin** : [http://localhost:2368/ghost](http://localhost:2368/ghost)
- **Site public** : [http://localhost:2368](http://localhost:2368)

### 6. Coordonnées GPS (Latitude & Longitude)

Chaque lieu correspond à un post Ghost. Pour chaque post, il faut renseigner les coordonnées GPS afin que le lieu s’affiche correctement sur la carte.

Trouver les coordonnées GPS ici : [https://www.geoplaner.com/](https://www.geoplaner.com/)

Exemple pour Boston, syntaxe à respecter :

1. Dans Code injection > Header
```bash
<meta name="latitude" content="42.35543">
```

2. Dans Code injection > Footer
```bash
<meta name="longitude" content="-71.06051">
```

### 7. Étapes suivantes

- Ajouter articles/pages/tags dans Ghost
- Explorer l’API Content : `/ghost/api/content/`
- Tester l’API Admin : `/ghost/api/admin/`
- Préparer un déploiement en production : Railway, Render, Pikapods, DigitalPress, VPS…
- Tester une approche _headless CMS_ (Ghost en backend) avec un frontend Gatsby ou Next.js déployé sur Netlify/Vercel.

## Contact

📬 Email : oliveur.twist.again[at]proton.me
