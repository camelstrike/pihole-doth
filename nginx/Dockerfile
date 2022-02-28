# syntax=docker/dockerfile:1.3-labs
ARG NGINX_TAG
FROM nginx:$NGINX_TAG

COPY nginx.conf.template /tmp/nginx.conf.template
COPY supervisord.conf /etc/supervisord.conf

ARG CERTBOT_DOMAIN
RUN <<EOT
apk add --no-cache git
git clone https://github.com/TuxInvader/nginx-dns.git /tmp/nginx-dns
[ -d /etc/nginx/njs.d ] && echo "njs.d dir exists" || mkdir /etc/nginx/njs.d
cp -r /tmp/nginx-dns/njs.d /etc/nginx/
rm -r /tmp/nginx-dns
envsubst '${CERTBOT_DOMAIN}' < /tmp/nginx.conf.template > /etc/nginx/nginx.conf
apk del git
apk add --no-cache supervisor
mkdir /var/log/supervisor
EOT

# Run supervisor
ENTRYPOINT [ "/usr/bin/supervisord", "-c", "/etc/supervisord.conf" ]