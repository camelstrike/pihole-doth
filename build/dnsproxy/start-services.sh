#!/bin/sh

# Create letsencrypt dir and generate self-signed certs
if [ ! -d /etc/letsencrypt/live/${CERTBOT_DOMAIN} ]
then
    mkdir -p /etc/letsencrypt/live/${CERTBOT_DOMAIN}
    openssl req -x509 -nodes -newkey rsa:4096 -days 1 -keyout /etc/letsencrypt/live/${CERTBOT_DOMAIN}/privkey.pem -out /etc/letsencrypt/live/${CERTBOT_DOMAIN}/fullchain.pem -subj '/CN=localhost'
else
    continue
fi

# Start supervisor
/usr/bin/supervisord -c /etc/supervisor/supervisord.conf
