FROM debian:bullseye

RUN apt-get update && apt-get install -y \
    nginx openssl \
    && rm -rf /var/lib/apt/lists/*

COPY ./tools/configure.sh /tmp/configure.sh
COPY ./conf/default.conf /etc/nginx/sites-available/default
COPY ./conf/nginx.conf /etc/nginx/nginx.conf

RUN chmod +x /tmp/configure.sh

EXPOSE 443

ENTRYPOINT ["/tmp/configure.sh"]