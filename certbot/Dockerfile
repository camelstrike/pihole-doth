# syntax=docker/dockerfile:1.3-labs
ARG CERTBOT_TAG
FROM alpine:$CERTBOT_TAG

COPY <<supercronic /opt/pihole-doth/
# Run certbot-cert.sh evrey 6 hours
00 */6 * * * /opt/pihole-doth/certbot-cert.sh
#*/50 * * * * * * /opt/pihole-doth/certbot-cert.sh
supercronic

COPY --chmod=760 certbot-cert.sh /opt/pihole-doth/certbot-cert.sh
COPY --chmod=760 start-services.sh /opt/pihole-doth/start-services.sh

RUN <<EOF
apk update
apk add --no-cache supervisor supercronic openssl python3 python3-dev py3-pip build-base libressl-dev musl-dev libffi-dev rust cargo 
pip install certbot certbot-dns-cloudflare
pip cache purge
apk del python3 python3-dev build-base musl-dev libffi-dev rust cargo
EOF

ENTRYPOINT ["/opt/pihole-doth/start-services.sh"]