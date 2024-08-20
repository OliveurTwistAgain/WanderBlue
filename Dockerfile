FROM ghost:latest

# Copier seulement le contenu nécessaire (thèmes, images, etc.)
COPY ./content /var/lib/ghost/content

# Copier config.production.json pour la config de Ghost
COPY ./config.production.json /var/lib/ghost/config.production.json

# Exposer le port pour l'application Ghost
EXPOSE 2368

RUN echo "HOST:"
RUN echo $MYSQLHOST
RUN echo "PORT:"
RUN echo $MYSQLPORT
