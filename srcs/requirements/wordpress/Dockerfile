FROM debian:bullseye

# Install CA certificates first
RUN apt-get update && \
    apt-get install -y ca-certificates && \
    update-ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# Create required directories
RUN mkdir -p /var/www /run/php && \
    chown www-data:www-data /run/php

# Install packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    php-fpm \
    php-mysql \
    php-json \
    php-curl \
    php-dom \
    php-exif \
    php-fileinfo \
    php-mbstring \
    php-xml \
    php-zip \
    wget \
    mariadb-client \
    curl \
    && rm -rf /var/lib/apt/lists/* && \
    apt-get clean

# Download and setup WordPress
RUN wget https://wordpress.org/latest.tar.gz \
    && tar -xzf latest.tar.gz -C /var/www/ \
    && rm -f latest.tar.gz \
    && mkdir -p /var/www/wordpress/wp-content/uploads \
    && chown -R www-data:www-data /var/www/wordpress \
    && find /var/www/wordpress -type d -exec chmod 755 {} \; \
    && find /var/www/wordpress -type f -exec chmod 644 {} \;

COPY conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf
COPY tools/configure.sh /tmp/configure.sh

RUN chmod +x /tmp/configure.sh

EXPOSE 9000

CMD ["/tmp/configure.sh"]