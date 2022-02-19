ARG NGINX_TAG
FROM nginx:$NGINX_TAG

RUN apk add --no-cache gcc build-base openssl-dev musl-dev libffi-dev cargo python3-dev py3-pip \
&& pip install certbot certbot-dns-cloudflare \
&& apk del gcc build-base openssl-dev musl-dev libffi-dev cargo

