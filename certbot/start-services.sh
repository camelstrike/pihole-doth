#!/bin/sh

# Set cloudflare token
echo "dns_cloudflare_api_token = $CLOUDFLARE_TOKEN" > /opt/pihole-doth/cloudflare.ini

# Create letsencrypt dir and generate self-signed certs
mkdir -p /etc/letsencrypt/live/${CERTBOT_DOMAIN}
openssl req -x509 -nodes -newkey rsa:4096 -days 1 -keyout /etc/letsencrypt/live/${CERTBOT_DOMAIN}/privkey.pem -out /etc/letsencrypt/live/${CERTBOT_DOMAIN}/fullchain.pem -subj '/CN=localhost'

# Generate letsencrypt cert
/opt/pihole-doth/certbot-cert.sh

# Run certbot renewal cron job
supercronic /opt/pihole-doth/supercronic