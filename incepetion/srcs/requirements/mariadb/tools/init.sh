#!/bin/sh
set -e

echo "[INFO] Reading secrets..."
MYSQL_ROOT_PASSWORD=$(cat /run/secrets/db_root_password)
MYSQL_USER=$(cat /run/secrets/db_user)
MYSQL_PASSWORD=$(cat /run/secrets/db_password)
MYSQL_DATABASE=wordpress_db

# Ensure the MySQL data directory is initialized
if [ ! -d "/var/lib/mysql/mysql" ]; then
  echo "[INFO] First run: initializing MariaDB data directory..."
  mysql_install_db --user=mysql --ldata=/var/lib/mysql > /dev/null

  echo "[INFO] Running bootstrap SQL setup..."
  mysqld --user=mysql --bootstrap << EOF
USE mysql;
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\` CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';
FLUSH PRIVILEGES;
EOF
else
  echo "[INFO] MariaDB already initialized — skipping setup."
fi

# Fix permissions
chown -R mysql:mysql /var/lib/mysql

# THIS IS THE FIX: use `mysqld_safe` which restarts on failure
echo "[INFO] Starting MariaDB safely..."
exec mysqld_safe --user=mysql