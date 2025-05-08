#!/bin/bash

# Create SSL certs if they don’t exist
if [ ! -f /etc/ssl/certs/nginx-selfsigned.crt ]; then
    mkdir -p /etc/ssl/private
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
        -keyout /etc/ssl/private/nginx-selfsigned.key \
        -out /etc/ssl/certs/nginx-selfsigned.crt \
        -subj "/C=FR/ST=Paris/L=Paris/O=42/OU=Student/CN=$DOMAIN_NAME"
fi

# Start nginx in foreground
nginx -g "daemon off;"