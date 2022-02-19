# bash ./get-cert.sh EMAIL DOMAIN_NAME

sudo certbot certonly \
  --dns-cloudflare \
  --no-eff-email \
  --agree-tos \
  --preferred-chain "ISRG Root X1" \
  -m "$1" \
  --dns-cloudflare-credentials ~/pihole-DoT/cloudflare/cloudflare.ini \
  --dns-cloudflare-propagation-seconds 60 \
  -d "$2"
