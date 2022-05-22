#!/bin/sh

# Set cloudflare token
echo "dns_cloudflare_api_token = $CLOUDFLARE_TOKEN" > /opt/pihole-doth/cloudflare.ini

# Generate letsencrypt cert
/opt/pihole-doth/certbot-cert.sh

# Run certbot renewal cron job
cron -f /opt/pihole-doth/supercronic