# syntax=docker/dockerfile:1.3-labs
FROM alpine:3.15

RUN <<EOT
apk add --no-cache unbound
EOT

COPY pi-hole.conf /etc/unbound/unbound.conf

EXPOSE 5335/tcp
EXPOSE 5335/udp

CMD [ "unbound", "-d" ]
