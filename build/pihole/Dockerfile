# syntax=docker/dockerfile:1.3-labs
ARG PIHOLE_TAG
FROM pihole/pihole:$PIHOLE_TAG

RUN <<EOT
echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
apt-get update && apt-get install -Vy php-cli php-sqlite3 php-intl php-curl wget tini gettext-base
wget -O - https://raw.githubusercontent.com/jacklul/pihole-updatelists/master/install.sh | bash /dev/stdin docker
EOT

COPY crontab /etc/pihole-updatelists/crontab
COPY pihole-updatelists.conf.template /tmp/pihole-updatelists.conf.template
COPY --chmod=760 start-services.sh /opt/pihole-doth/start-services.sh

ENTRYPOINT ["/usr/bin/tini", "--", "/opt/pihole-doth/start-services.sh"]
