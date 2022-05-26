# syntax=docker/dockerfile:1.3-labs
FROM ubuntu:22.04

COPY <<supercronic /opt/pihole-doth/
# Run certbot-cert.sh evrey 6 hours
00 */6 * * * /opt/pihole-doth/certbot-cert.sh
#*/50 * * * * * * /opt/pihole-doth/certbot-cert.sh
supercronic

COPY --chmod=760 certbot-cert.sh /opt/pihole-doth/certbot-cert.sh
COPY --chmod=760 start-services.sh /opt/pihole-doth/start-services.sh

RUN <<EOF
echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
apt update
apt install supervisor tini cron certbot python3-certbot-dns-cloudflare -y
EOF

ENTRYPOINT ["/usr/bin/tini", "--", "/opt/pihole-doth/start-services.sh"]
