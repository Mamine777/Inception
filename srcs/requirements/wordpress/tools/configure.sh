#!/bin/bash

# Enhanced database connection checker
check_db() {
    # Test basic TCP connectivity
    if ! (exec 3<>/dev/tcp/mariadb/3306) 2>/dev/null; then
        echo "$(date) - Cannot reach mariadb:3306"
        return 1
    fi

    # Verify MySQL credentials
    if ! mysql -h mariadb \
              -u"$(cat ${MYSQL_USER_FILE})" \
              -p"$(cat ${MYSQL_PASSWORD_FILE})" \
              -e "SELECT 1" 2>/dev/null; then
        echo "$(date) - Connection established but authentication failed"
        echo "Credentials used:"
        echo "User: $(cat ${MYSQL_USER_FILE})"
        echo "Database: ${MYSQL_DATABASE}"
        return 1
    fi

    # Verify database exists
    if ! mysql -h mariadb \
              -u"$(cat ${MYSQL_USER_FILE})" \
              -p"$(cat ${MYSQL_PASSWORD_FILE})" \
              -e "USE ${MYSQL_DATABASE}" 2>/dev/null; then
        echo "$(date) - Database ${MYSQL_DATABASE} doesn't exist"
        return 1
    fi

    echo "$(date) - Database connection successful"
    return 0
}

# Wait for database with timeout (120 seconds max)
timeout=120
while [ $timeout -gt 0 ]; do
    if check_db; then
        break
    fi
    sleep 2
    timeout=$((timeout-2))
done

if [ $timeout -le 0 ]; then
    echo "ERROR: Timed out waiting for database"
    echo "Last status:"
    check_db  # Show full error output
    exit 1
fi

# Start PHP-FPM in foreground
echo "Starting PHP-FPM..."
exec php-fpm7.4 -F