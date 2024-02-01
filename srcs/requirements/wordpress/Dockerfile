# Dockerfile for the WordPress service

FROM debian:bullseye

RUN apt-get update -y && apt-get upgrade -y
    
RUN apt-get install -y curl mariadb-client iputils-ping

RUN apt-get install -y php7.4 php7.4-fpm php7.4-curl php7.4-mysql \
    php7.4-mbstring php7.4-xml php7.4-zip php7.4-gd php7.4-imap

RUN mkdir -p /run/php

RUN mkdir -p /var/www/html

RUN chown -R www-data:www-data /var/www/html/

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

RUN chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp

COPY ./www.conf /etc/php/7.4/fpm/pool.d/www.conf

COPY ./wordscript.sh /usr/local/bin

RUN chmod +x /usr/local/bin//wordscript.sh

EXPOSE 9000

ENTRYPOINT ["/usr/local/bin/wordscript.sh"]

CMD ["php-fpm7.4", "-F"]
