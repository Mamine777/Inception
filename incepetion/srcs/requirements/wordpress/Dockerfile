FROM debian:bullseye

ENV WP_PATH=/var/www/wordpress

RUN apt-get update && apt-get install -y \
    php \
    php-fpm \
    php-mysqli \
    php-json \
    php-curl \
    php-mbstring \
    php-exif \
    php-opcache \
    php-gd \
    php-xml \
    php-common \
    curl \
    mariadb-client \
    unzip \
    nano \
    && rm -rf /var/lib/apt/lists/*

# Create required folders
RUN mkdir -p $WP_PATH /run/php

# Change PHP-FPM to listen on TCP port 9000
RUN sed -i 's|listen = .*|listen = 0.0.0.0:9000|' /etc/php/7.4/fpm/pool.d/www.conf

# Install wp-cli
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp

# Copy entrypoint
COPY tools/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 9000

ENTRYPOINT ["/entrypoint.sh"]