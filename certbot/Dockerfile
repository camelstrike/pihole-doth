# syntax=docker/dockerfile:1.3-labs
ARG CERTBOT_TAG
FROM certbot/dns-cloudflare:$CERTBOT_TAG


ARG CLOUDFLARE_TOKEN
COPY <<cloudflare.ini <<supercronic /opt/pihole-doth/
dns_cloudflare_api_token = $CLOUDFLARE_TOKEN
cloudflare.ini
# Run certbot-cert.sh evrey 6 hours
00 */6 * * * /opt/pihole-doth/certbot-cert.sh
#*/50 * * * * * * /opt/pihole-doth/certbot-cert.sh
supercronic

COPY --chmod=760 certbot-cert.sh /opt/pihole-doth/certbot-cert.sh
COPY --chmod=760 start-services.sh /opt/pihole-doth/start-services.sh

ARG CERTBOT_DOMAIN
RUN <<EOF
apk update
apk upgrade
sed -i s/3.12/3.15/g /etc/apk/repositories
apk update
apk upgrade
apk add --no-cache supercronic
pip install supervisor
mkdir -p /etc/letsencrypt/live/${CERTBOT_DOMAIN}
openssl req -x509 -nodes -newkey rsa:4096 -days 1 -keyout /etc/letsencrypt/live/${CERTBOT_DOMAIN}/privkey.pem -out /etc/letsencrypt/live/${CERTBOT_DOMAIN}/fullchain.pem -subj '/CN=localhost'
EOF

ARG CERTBOT_DOMAIN
ARG CERTBOT_EMAIL
ARG CERTBOT_ENV
ENV CERTBOT_DOMAIN=${CERTBOT_DOMAIN} \
    CERTBOT_EMAIL=${CERTBOT_EMAIL} \
    CERTBOT_ENV=${CERTBOT_ENV}

ENTRYPOINT ["/opt/pihole-doth/start-services.sh"]