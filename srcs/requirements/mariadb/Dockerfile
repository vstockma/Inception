# Use the penultimate stable version of Debian
FROM debian:bullseye

# Install MariaDB
RUN apt-get update && apt-get upgrade -y

RUN apt-get install -y mariadb-server mariadb-client

RUN mkdir -p /run/mysqld /var/lib/mysql

# give the mysql user and group permission to work with these dirs
RUN chown -R mysql:mysql /run/mysqld /var/lib/mysql

# initialize the database
RUN mysql_install_db --user=mysql --datadir=/var/lib/mysql --auth-root-authentication-method=normal --skip-test-db

COPY ./my.conf /etc/mysql/my.cnf

COPY ./mariascript.sh /usr/local/bin/

RUN chmod +x /usr/local/bin//mariascript.sh

EXPOSE 3306

ENTRYPOINT ["/usr/local/bin/mariascript.sh"]

CMD ["/usr/bin/mysqld_safe", "--datadir=/var/lib/mysql"]

