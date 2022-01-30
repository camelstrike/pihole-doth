# bash ./get-cert.sh EMAIL DOMAIN_NAME

sudo certbot certonly \
  --dns-cloudflare \
  --no-eff-email \
  --agree-tos \
  -m "$1" \
  --dns-cloudflare-credentials ~/pihole-DoT/assets/cloudflare/cloudflare.ini \
  --dns-cloudflare-propagation-seconds 60 \
  -d "$2"
