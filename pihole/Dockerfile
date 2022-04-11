# syntax=docker/dockerfile:1.3-labs
ARG PIHOLE_TAG
FROM pihole/pihole:$PIHOLE_TAG

RUN <<EOT
echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
apt-get update && apt-get install -Vy php-cli php-sqlite3 php-intl php-curl wget
wget -O - https://raw.githubusercontent.com/jacklul/pihole-updatelists/master/install.sh | bash /dev/stdin docker
echo "namerserver 127.0.0.1" > /etc/resolv.conf
EOT

COPY crontab /etc/pihole-updatelists/crontab
