# Dockerfile for the WordPress service

FROM debian:bullseye

RUN apt-get update -y && apt-get upgrade -y
    
RUN apt-get install -y curl mariadb-client iputils-ping

# Diese Erweiterungen erweitern die Kernfunktionalität von PHP
# um Anwendungen zu ermöglichen, mit verschiedenen Datenformaten zu arbeiten
RUN apt-get install -y php7.4 php7.4-fpm php7.4-curl php7.4-mysql \
    php7.4-mbstring php7.4-xml php7.4-zip php7.4-gd php7.4-imap

# erstellen eines directory für temporäre Dateien
RUN mkdir -p /run/php

# erstellt directory für das volume von wordpress
RUN mkdir -p /var/www/html

# Änderungen der Rechte für zugriff des Standardenutzer www-data
RUN chown -R www-data:www-data /var/www/html/

# WordPress Command-Line Interface wird herunterzuladen,
# ausführbar gemacht und an einen globalen Speicherort verschoben
# wp befehle werden so leichter ausführbar
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

RUN chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp

# das standard configfile wird mit dem eigenen überschrieben
COPY ./www.conf /etc/php/7.4/fpm/pool.d/www.conf

# kopiert das script an einen global verfügbaren Punkt
COPY ./wordscript.sh /usr/local/bin

RUN chmod +x /usr/local/bin//wordscript.sh

EXPOSE 9000

# führt die script datei aus
ENTRYPOINT ["/usr/local/bin/wordscript.sh"]

#startet wordpress
CMD ["php-fpm7.4", "-F"]