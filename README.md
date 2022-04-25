# Pihole DNS over TLS/HTTPS
This project aims to create a Pihole DNS over TLS/HTTPS solution running on docker. Docker images are compatible with AMD64/ARM64 cpu archs.
It makes use of the following projects:
- [pi-hole](https://github.com/pi-hole/pi-hole "pi-hole")
- [nginx-dns](https://github.com/TuxInvader/nginx-dns "nginx-dns")
- [certbot](https://github.com/certbot/certbot "certbot")
- [unbound](https://github.com/NLnetLabs/unbound "unbound")

## Requirements
- A Domain Name
- [Cloudflare API Token](https://dash.cloudflare.com/profile/api-tokens "Cloudflare API Token")
- Ubuntu 20.04
- Docker
	```bash
	curl -fsSL https://get.docker.com | bash
	```
- Docker-compose
	```bash
	sudo curl -L "https://github.com/docker/compose/releases/download/v2.4.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
	sudo chmod +x /usr/local/bin/docker-compose
	sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
	```



## Configuration
#### Enable Docker BuildKit
Make sure BuildKit is enabled in docker, add the following to **/etc/docker/daemon.json**
```
{ "features": { "buildkit": true } }
```
Restart docker
```
sudo systemctl restart docker
```

#### Free up port 53 on host
We need this port free so nginx can use it, by default resolved service comes enabled in Ubuntu and uses this port.

Update the following on **/etc/systemd/resolved.conf**
```
DNS=SOME_DNS_SERVER
DNSStubListener=no
```
Create a symlink and restart systemd-resolved service
```
sudo ln -sf /run/systemd/resolve/resolv.conf /etc/resolv.conf
sudo systemctl restart systemd-resolved.service
```

#### Get a Cloudflare API Token
Create an API Token with the following information, this will be used by certbot to create  TXT records in Cloudflare for Let´s encrypt to verify domain ownership and provide an SSL certificate.

**Premissions:** Zone -> DNS -> Edit
**Zone Resources:** Include -> Specific Zone -> YOUR_DOMAIN_NAME

#### Update environment variables
You can set your env vars in the following ways (choose one):
1. With **set-env_vars.sh** script provided

	Run
	```
	bash set-env_vars.sh
	```
	Load env vars
	```
	source ~/.pihole-doth
	```

2. Updating **.env** file, by default it uses the env vars set in your shell with some default values (:-)
	```
	PIHOLE_WEBPASSWORD=YOUR_PIHOLE_PASSWORD
	CLOUDFLARE_TOKEN=YOUR_ CLOUDFLARE_TOKEN
	CERTBOT_DOMAIN=YOUR_DOMAIN
	CERTBOT_EMAIL=YOUR_EMAIL
	CERTBOT_ENV=staging or production
	```

## Usage
```
docker-compose up
```