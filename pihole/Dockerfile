ARG TAG
FROM pihole/pihole:$TAG

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections \
&& apt-get update && apt-get install -Vy php-cli php-sqlite3 php-intl php-curl

RUN wget -O - https://raw.githubusercontent.com/jacklul/pihole-updatelists/master/install.sh | bash /dev/stdin docker
