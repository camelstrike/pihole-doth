#!/bin/sh

# Generate template for our domain
envsubst '${CERTBOT_DOMAIN}' < /tmp/nginx.conf.template > /etc/nginx/nginx.conf

# Start supervisor
/usr/bin/supervisord -c /etc/supervisord.conf