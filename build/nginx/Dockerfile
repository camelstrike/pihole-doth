# syntax=docker/dockerfile:1.3-labs
ARG NGINX_TAG
FROM nginx:$NGINX_TAG

COPY nginx.conf.template /tmp/nginx.conf.template
COPY supervisord.conf /etc/supervisord.conf
COPY --chmod=760 start-services.sh /opt/pihole-doth/start-services.sh

RUN <<EOT
apk add --no-cache git openssl tini
git clone https://github.com/TuxInvader/nginx-dns.git /tmp/nginx-dns
[ -d /etc/nginx/njs.d ] && echo "njs.d dir exists" || mkdir /etc/nginx/njs.d
cp -r /tmp/nginx-dns/njs.d /etc/nginx/
rm -r /tmp/nginx-dns
apk del git
apk add --no-cache supervisor
mkdir /var/log/supervisor
EOT

STOPSIGNAL SIGTERM

ENTRYPOINT ["/sbin/tini", "--", "/opt/pihole-doth/start-services.sh"]