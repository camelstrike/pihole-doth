# syntax=docker/dockerfile:1.3-labs
ARG NGINX_TAG
FROM nginx:$NGINX_TAG

COPY nginx.conf.template /tmp/nginx.conf.template
COPY 40-start-sshd.sh /docker-entrypoint.d/40-start-sshd.sh

ARG CERTBOT_DOMAIN
RUN <<EOT
apk add --no-cache git openssh
git clone https://github.com/TuxInvader/nginx-dns.git /tmp/nginx-dns
[ -d /etc/nginx/njs.d ] && echo "njs.d dir exists" || mkdir /etc/nginx/njs.d
cp -r /tmp/nginx-dns/njs.d /etc/nginx/
rm -r /tmp/nginx-dns
envsubst '${CERTBOT_DOMAIN}' < /tmp/nginx.conf.template > /etc/nginx/nginx.conf
mkdir -p ~/.ssh /opt/pihole-doth
ssh-keygen -t ED25519 -f /opt/pihole-doth/id_ed25519 -q -N ""
cat /opt/pihole-doth/id_ed25519.pub > ~/.ssh/authorized_keys
sed -i s/root:!/"root:*"/g /etc/shadow
apk del git
EOT