#bin/bash

CERT_DIR="./srcs/requirements/nginx/ssl"

mkdir -p "$CERT_DIR"

openssl req -x509 -nodes -days 365 \
    -newkey rsa:2048 \
    -keyout "$CERT_DIR/mokariou.42.fr.key" \
    -out "$CERT_DIR/mokariou.42.fr.crt" \
    -subj "/C=FR/ST=Paris/L=Paris/O=42/OU=student/CN=mokariou.42.fr"
echo "ssl certificate generated in $CERT_DIR twin"