FROM debian:bullseye

RUN apt-get update && apt-get install -y \
    mariadb-server \
    mariadb-client && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /run/mysqld
RUN chown -R mysql:mysql /run/mysqld

COPY conf/my.cnf /etc/mysql/my.cnf
COPY tools/init.sh /init.sh

RUN chmod +x /init.sh

ENV MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD \
    MYSQL_DATABASE=$MYSQL_DATABASE \
    MYSQL_USER=$MYSQL_USER \
    MYSQL_PASSWORD=$MYSQL_PASSWORD
EXPOSE 3306

VOLUME ["/var/lib/mysql"]

CMD ["/bin/sh", "-c", "/init.sh && exec mysql --user=mysql --console"]
