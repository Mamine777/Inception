FROM debian:bullseye

RUN apt-get update && apt-get install -y \
    nginx \
    openssl

RUN mkdir -p /var/run/nginx

COPY conf/nginx.conf /etc/nginx/nginx.conf
COPY conf/default.conf /etc/nginx/conf.d/default.conf
COPY tools/configure.sh /tmp/configure.sh

RUN chmod +x /tmp/configure.sh

EXPOSE 443

ENTRYPOINT ["/tmp/configure.sh"]