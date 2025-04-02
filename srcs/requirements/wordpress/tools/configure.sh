#!/bin/bash

# Set PHP-FPM socket directory permissions
mkdir -p /run/php
chown www-data:www-data /run/php

# Verify and fix WordPress permissions
chown -R www-data:www-data /var/www/wordpress
find /var/www/wordpress -type d -exec chmod 755 {} \;
find /var/www/wordpress -type f -exec chmod 644 {} \;
chmod -R 775 /var/www/wordpress/wp-content/uploads

# Wait for MariaDB to be ready
timeout=60
while ! mysqladmin ping -h mariadb -u$(cat ${MYSQL_USER_FILE}) -p$(cat ${MYSQL_PASSWORD_FILE}) --silent && [ $timeout -gt 0 ]; do
    sleep 2
    timeout=$((timeout-2))
    echo "Waiting for database... (${timeout}s remaining)"
done

if [ $timeout -le 0 ]; then
    echo "ERROR: Database connection timed out"
    exit 1
fi

# Start PHP-FPM in foreground
exec php-fpm7.4 -F