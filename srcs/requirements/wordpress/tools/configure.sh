#!/bin/bash

# Create PHP-FPM runtime directory
mkdir -p /run/php /var/php
chown www-data:www-data /run/php

pkill php-fpm7.4 || true
rm -rf /run/php/php7.4-fpm.sock

# Database connection check
check_db() {
    mysql -h mariadb \
          -u"$(cat ${MYSQL_USER_FILE})" \
          -p"$(cat ${MYSQL_PASSWORD_FILE})" \
          -e "SELECT 1" &>/dev/null
    return $?
}

# Wait for database
timeout=60
while ! check_db && [ $timeout -gt 0 ]; do
    echo "$(date) - Waiting for MariaDB... (${timeout}s remaining)"
    sleep 2
    timeout=$((timeout-2))
done

if [ $timeout -le 0 ]; then
    echo "ERROR: Timed out waiting for database"
    exit 1
fi

# Keep container running
exec php-fpm7.4 -F