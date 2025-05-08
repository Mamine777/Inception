#!/bin/bash

mkdir -p /run/php
mkdir -p /var/www/wordpress
cd /var/www/wordpress

# Wait for MariaDB
echo "Waiting for MariaDB..."
until mysqladmin ping -h mariadb --silent; do
    sleep 1
done

# Install WordPress if not already
if [ ! -f wp-config.php ]; then
    echo "wp-config.php not found --generating wordpress setyp"
    wp core download --allow-root

    wp config create \
        --dbname="$MYSQL_DATABASE" \
        --dbuser="$MYSQL_USER" \
        --dbpass="$MYSQL_PASSWORD" \
        --dbhost="mariadb" \
        --allow-root

    wp core install \
        --url="$DOMAIN_NAME" \
        --title="Inception" \
        --admin_user="$WP_ADMIN_USER" \
        --admin_password="$WP_ADMIN_PASSWORD" \
        --admin_email="$WP_ADMIN_EMAIL" \
        --allow-root

    wp user create "$WP_USER" "$WP_USER_EMAIL" \
        --user_pass="$WP_USER_PASSWORD" \
        --role=author \
        --allow-root
fi

chown -R www-data:www-data /var/www/wordpress
exec php-fpm7.4 -F