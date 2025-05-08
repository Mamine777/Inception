FROM debian:bullseye

RUN apt-get update && apt-get install -y \
    mariadb-server \
    && rm -rf /var/lib/apt/lists/*

COPY ./tools/configure.sh /tmp/configure.sh
COPY ./conf/my.cnf /etc/mysql/my.cnf

RUN chmod +x /tmp/configure.sh

EXPOSE 3306

ENTRYPOINT ["/tmp/configure.sh"]

