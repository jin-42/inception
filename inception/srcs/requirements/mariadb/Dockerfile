FROM debian:bullseye

RUN apt-get update && apt-get install -y \
    mariadb-server \
    && rm -rf /var/lib/apt/lists/*

# Copy MariaDB configuration
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

# Copy database setup script
COPY tools/mariadb-setup.sh /usr/local/bin/mariadb-setup.sh
RUN chmod +x /usr/local/bin/mariadb-setup.sh

# Create directory for MariaDB
RUN mkdir -p /var/run/mysqld && chown mysql:mysql /var/run/mysqld

EXPOSE 3306

CMD ["/usr/local/bin/mariadb-setup.sh"]
