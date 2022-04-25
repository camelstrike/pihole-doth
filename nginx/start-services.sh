#!/bin/sh

# Create letsencrypt dir and generate self-signed certs
mkdir -p /etc/letsencrypt/live/${CERTBOT_DOMAIN}
openssl req -x509 -nodes -newkey rsa:4096 -days 1 -keyout /etc/letsencrypt/live/${CERTBOT_DOMAIN}/privkey.pem -out /etc/letsencrypt/live/${CERTBOT_DOMAIN}/fullchain.pem -subj '/CN=localhost'

# Generate template for our domain
envsubst '${CERTBOT_DOMAIN}' < /tmp/nginx.conf.template > /etc/nginx/nginx.conf

# Start supervisor
/usr/bin/supervisord -c /etc/supervisord.conf