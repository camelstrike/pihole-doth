# syntax=docker/dockerfile:1.3-labs
FROM golang:1.18-bullseye as builder

RUN <<EOT
git clone --depth 1 --branch v0.43.0 https://github.com/AdguardTeam/dnsproxy /usr/src/app
EOT

WORKDIR /usr/src/app

RUN go build -v -o /usr/local/bin/dnsproxy -mod=vendor

FROM ubuntu:22.04

RUN <<EOT
apt update
apt install supervisor tini openssl -y
EOT

COPY supervisord.conf /etc/supervisor/supervisord.conf
COPY --chmod=760 start-services.sh /opt/pihole-doth/start-services.sh
COPY --from=builder /usr/local/bin/dnsproxy /usr/local/bin/dnsproxy

WORKDIR /usr/src/app

ENTRYPOINT ["/usr/bin/tini", "--", "/opt/pihole-doth/start-services.sh"]