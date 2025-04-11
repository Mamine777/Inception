#!/bin/sh
set -e

WP_PATH=/var/www/wordpress

# Wait for MariaDB to be ready
echo "Waiting for MariaDB..."
until mysqladmin ping -h"$MYSQL_HOST" -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" --silent; do
    sleep 1
done
echo "MariaDB is up!"

# Download wp-cli if missing
if [ ! -f /usr/local/bin/wp ]; then
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    chmod +x wp-cli.phar
    mv wp-cli.phar /usr/local/bin/wp
fi

# Set proper permissions
chown -R www-data:www-data $WP_PATH

# Install WordPress if not already installed
if [ ! -f "$WP_PATH/wp-config.php" ]; then
    wp core config --path=$WP_PATH \
        --dbname=$MYSQL_DATABASE \
        --dbuser=$MYSQL_USER \
        --dbpass=$MYSQL_PASSWORD \
        --dbhost=$MYSQL_HOST \
        --allow-root

    wp core install --path=$WP_PATH \
        --url=$DOMAIN_NAME \
        --title="Inception Site" \
        --admin_user=$WP_ADMIN_USER \
        --admin_password=$WP_ADMIN_PASSWORD \
        --admin_email=$WP_ADMIN_EMAIL \
        --skip-email \
        --allow-root
fi

# Run PHP-FPM version 7.4
exec php-fpm7.4 -F