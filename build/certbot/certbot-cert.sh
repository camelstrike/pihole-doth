#!/bin/sh

sleep 30

CERTBOT_DIR="/etc/letsencrypt/live"
CERTBOT_RELOAD_DNSPROXY="supervisorctl -s http://dnsproxy:9001 restart dnsproxy"

CERTBOT_ARGS=$(
if [ "$CERTBOT_ENV" = "staging" ]
 then
  echo "$CERTBOT_DOMAIN --test-cert"
elif [ "$CERTBOT_ENV" = "production" ]
 then
  echo "$CERTBOT_DOMAIN"
else
 echo "error"
fi
)
IS_CERT_AVAIL=$([ -d "$CERTBOT_DIR"/"$CERTBOT_DOMAIN" ] && echo true || echo false)
IS_CERT_SELF_SIGNED=$([ "$(openssl x509 -in "$CERTBOT_DIR"/"$CERTBOT_DOMAIN"/fullchain.pem -text -noout | grep -oE 'Subject: CN =.*' | cut -d" " -f4)" = "localhost" ] && echo true || echo false)

if [ "$CERTBOT_ARGS" != "error" ] && [ "$IS_CERT_SELF_SIGNED" = "true" ]
 then
  rm -r "${CERTBOT_DIR:?}/"*
  certbot certonly \
  --dns-cloudflare \
  --no-eff-email \
  --agree-tos \
  --preferred-chain "ISRG Root X1" \
  -m "$CERTBOT_EMAIL" \
  --dns-cloudflare-credentials /opt/pihole-doth/cloudflare.ini \
  --dns-cloudflare-propagation-seconds 30 \
  -d $CERTBOT_ARGS --post-hook "$CERTBOT_RELOAD_DNSPROXY"
elif [ "$IS_CERT_AVAIL" = "true" ] && [ "$CERTBOT_ARGS" != "error" ] && [ "$IS_CERT_SELF_SIGNED" = "false" ]
 then
    certbot renew --post-hook "$CERTBOT_RELOAD_DNSPROXY"
else
 echo "Something is off or cert is self-signed, check logs"
 exit 0
fi