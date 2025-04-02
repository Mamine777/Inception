FROM debian:bullseye

# Install dependencies with proper cleanup
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
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
        curl && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean

# Create necessary directories with correct permissions
RUN mkdir -p /var/www/wordpress /run/php && \
    chown -R www-data:www-data /var/www /run/php

# Download and setup WordPress
RUN wget -q https://wordpress.org/latest.tar.gz && \
    tar -xzf latest.tar.gz -C /var/www/ --strip-components=1 && \
    rm -f latest.tar.gz && \
    mkdir -p /var/www/wordpress/wp-content/uploads && \
    chown -R www-data:www-data /var/www/wordpress && \
    find /var/www/wordpress -type d -exec chmod 755 {} \; && \
    find /var/www/wordpress -type f -exec chmod 644 {} \; && \
    chmod -R 775 /var/www/wordpress/wp-content/uploads

COPY conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf
COPY tools/configure.sh /tmp/configure.sh

RUN chmod +x /tmp/configure.sh

EXPOSE 9000

ENTRYPOINT ["/tmp/configure.sh"]