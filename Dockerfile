ARG PHP_VERSION=7.4
FROM php:${PHP_VERSION}-fpm

RUN apt-get update -y \
    && apt-get install -y nginx nano


# Color bash (ex: exec -ti bash)
ENV TERM=xterm-256color
RUN echo "PS1='\e[92m\u\e[0m@\e[94m\h\e[0m:\e[35m\w\e[0m# '" >> /root/.bashrc

ARG FOLDER_CONFIG=config
ARG FOLDER_APP=app
# REPERTOIRE TRAVAIL CONTENEUR
ARG WORKDIR=/var/www/monsite

COPY ${FOLDER_CONFIG}/nginx-site.conf /etc/nginx/sites-enabled/default
COPY ${FOLDER_CONFIG}/entrypoint.sh /etc/entrypoint.sh

WORKDIR ${WORKDIR}

COPY --chown=www-data:www-data ${FOLDER_APP} .

# CMD ["/etc/entrypoint.sh"]
ENTRYPOINT ["/etc/entrypoint.sh"]