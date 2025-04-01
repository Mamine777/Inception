#!/bin/bash

# Generate SSL certificate
mkdir -p /etc/ssl/private /etc/ssl/certs
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/ssl/private/nginx.key \
    -out /etc/ssl/certs/nginx.crt \
    -subj "/C=US/ST=State/L=City/O=Company/CN=${DOMAIN_NAME}"

# Start nginx
exec nginx -g "daemon off;"