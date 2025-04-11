FROM debian:bullseye

RUN apt-get update && apt-get install -y nginx openssl && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /etc/nginx/ssl /run/nginx

COPY conf/default.conf /etc/nginx/conf.d/default.conf

COPY ssl/mokariou.42.fr.crt /etc/nginx/ssl/mokariou.42.fr.crt
COPY ssl/mokariou.42.fr.key /etc/nginx/ssl/mokariou.42.fr.key
COPY tools/fpm.conf /etc/php/7.4/fpm/pool.d/www.conf
EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]