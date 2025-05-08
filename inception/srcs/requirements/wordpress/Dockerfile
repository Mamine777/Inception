FROM debian:bullseye

# Install PHP, extensions, MariaDB client, and tools
RUN apt-get update && apt-get install -y \
    php php-mysql php-fpm php-curl php-gd php-mbstring php-xml php-xmlrpc php-soap php-intl php-zip \
    mariadb-client curl wget unzip less \
    && rm -rf /var/lib/apt/lists/*

# Install WP-CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

# Copy config files and script
COPY ./tools/configure.sh /tmp/configure.sh
COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

RUN chmod +x /tmp/configure.sh

EXPOSE 9000

ENTRYPOINT ["/tmp/configure.sh"]