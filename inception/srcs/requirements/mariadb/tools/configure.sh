#!/bin/bash

# Initialize DB directory if not already
if [ ! -d "/var/lib/mysql/mysql" ]; then
    mariadb-install-db --user=mysql --basedir=/usr --datadir=/var/lib/mysql > /dev/null
fi

# Start mysqld in background
mysqld_safe --datadir=/var/lib/mysql &

# Wait for MariaDB to be ready
until mysqladmin ping --silent; do
    sleep 1
done

# Setup DB and user
mariadb -u root <<EOF
CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';
FLUSH PRIVILEGES;
EOF

# Keep foreground process running
wait

