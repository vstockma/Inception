# Use the penultimate stable version of Debian
FROM debian:bullseye

# Install MariaDB
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y mariadb-server mariadb-client

# Create directories for MariaDB to use
RUN mkdir -p /run/mysqld /var/lib/mysql

# Give the mysql user and group permission to work with these directories
RUN chown -R mysql:mysql /run/mysqld /var/lib/mysql

# initialize the database
RUN mysql_install_db --user=mysql --datadir=/var/lib/mysql --auth-root-authentication-method=normal --skip-test-db

# Copy the custom MariaDB configuration file
COPY ./my.conf /etc/mysql/my.cnf

# Copy the script for additional configuration and start
COPY ./mariascript.sh /usr/local/bin/
RUN chmod +x /usr/local/bin//mariascript.sh

# Expose port 3306 for external connections
EXPOSE 3306

# executes the mariascript.sh script
ENTRYPOINT ["/usr/local/bin/mariascript.sh"]

# start container
CMD ["/usr/bin/mysqld_safe", "--datadir=/var/lib/mysql"]

#mysql -u root
#mysql -u vstockma -p
#SHOW DATABASES;
#USE Inception;
#SHOW TABLES;

