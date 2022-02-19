# PDDoT/H - Pihole Docker DNS over TLS/HTTPS

## Requirements
- Ubuntu 20.04
- Docker

	```bash
	curl -fsSL https://get.docker.com | bash
	```

- Docker-compose

	```bash
	sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
	sudo chmod +x /usr/local/bin/docker-compose
	sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
	```


## Configure
Nginx - TCP Fast Open

Enable in Kernel
```
cat /proc/sys/net/ipv4/tcp_fastopen
echo "3" > /proc/sys/net/ipv4/tcp_fastopen
echo "net.ipv4.tcp_fastopen=3" > /etc/sysctl.d/30-tcp_fastopen.conf
sysctl --system
```