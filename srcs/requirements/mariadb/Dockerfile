FROM debian:bullseye

RUN apt-get update && apt-get install -y \
    mariadb-server \
    mariadb-client

COPY conf/my.cnf /etc/mysql/my.cnf
COPY tools/configure.sh /tmp/configure.sh

RUN chmod +x /tmp/configure.sh

EXPOSE 3306

VOLUME /var/lib/mysql

ENTRYPOINT ["/tmp/configure.sh"]