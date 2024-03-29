#!/bin/bash

#Überprüft, ob die WordPress-Konfigurationsdatei wp-config.php bereits vorhanden ist
if [ ! -f "/var/www/html/wp-config.php" ]; then

	chown -R www-data:www-data /var/www/html/
	cd /var/www/html

	wp core download --allow-root

	# wartet auf Verbindung zu MySQL-Datenbank
	until mysqladmin --user=${MYSQL_USER} --password=${MYSQL_PASS} --host=mariadb ping; do
		sleep 2
	done

	# Erstellt die WordPress-Konfigurationsdatei mit Daten aus .env
	wp config create	--dbname=${MYSQL_DB} \
						--dbuser=${MYSQL_USER} \
						--dbpass=${MYSQL_PASS} \
						--dbhost=mariadb \
						--allow-root

	# Installiert WordPress mit den angegebenen Einstellungen.
	wp core install		--url=vstockma.42.fr \
						--title=${WP_TITLE} \
						--admin_user=${WP_ADMIN} \
						--admin_password=${WP_ADMIN_PASS} \
						--admin_email=${WP_ADMIN_MAIL} \
						--allow-root

	# Erstellt einen WordPress-Benutzer mit den angegebenen Informationen.
	wp user create 		${WP_USER} ${WP_USER_MAIL} \
						--user_pass=${WP_USER_PASS} \
						--role=author \
						--allow-root

	# Installiert das WordPress-Theme
	wp theme install "Twenty Seventeen" --activate --allow-root

	# Erstellt einen Beispiel-Beitrag.
	wp post generate --count=1 --post_author="${WP_USER}" --post_title="This is 42!" --allow-root

fi;

exec "$@"
