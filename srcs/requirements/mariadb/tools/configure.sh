#!/bin/bash

if [ ! -d /var/lib/mysql/mysql ]; then
    mysql_install_db --user=mysql --datadir=/var/lib/mysql
fi

# Start mariadb in background
mysqld_safe --user=mysql --datadir=/var/lib/mysql &

# Wait for mariadb to start
while ! mysqladmin ping --silent; do
    sleep 1
done

# Create database and users
mysql -uroot -p"$(cat ${MYSQL_ROOT_PASSWORD_FILE})" -e "CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};"
mysql -uroot -p"$(cat ${MYSQL_ROOT_PASSWORD_FILE})" -e "CREATE USER IF NOT EXISTS '$(cat ${MYSQL_USER_FILE})'@'%' IDENTIFIED BY '$(cat ${MYSQL_PASSWORD_FILE})';"
mysql -uroot -p"$(cat ${MYSQL_ROOT_PASSWORD_FILE})" -e "GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '$(cat ${MYSQL_USER_FILE})'@'%';"
mysql -uroot -p"$(cat ${MYSQL_ROOT_PASSWORD_FILE})" -e "FLUSH PRIVILEGES;"

# Shutdown mariadb properly
mysqladmin -uroot -p"$(cat ${MYSQL_ROOT_PASSWORD_FILE})" shutdown

# Start mariadb in foreground
exec mysqld_safe --user=mysql --datadir=/var/lib/mysql