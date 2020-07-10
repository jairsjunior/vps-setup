#!/bin/bash

echo "########################################################################"
echo "# This file configure the instalation and configuration of:            #"
echo "# -> Docker                                                            #"
echo "# -> Swarm                                                             #"
echo "# -> Traefik w/ Let's Encrypt                                          #"
echo "########################################################################"

echo "########################################################################"
echo "Instaling docker..."
echo "########################################################################"
apt-get install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common && \
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - && \
apt-key fingerprint 0EBFCD88 && \
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" && \
touch /.dockerenv && \
apt-get update && \
apt-get install -y docker-ce docker-ce-cli containerd.io
echo "{ \"iptables\": true, \"log-driver\": \"journald\" }" > /etc/docker/daemon.json && \
service docker restart && \
sudo curl -L "https://github.com/docker/compose/releases/download/1.26.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && \
echo "########################################################################"
echo " -> Docker Installed and Configured!"
echo "########################################################################"
echo ""
echo ""
sleep 5

echo "########################################################################"
echo "Configure Swarm..."
echo "########################################################################"
docker swarm init && \
docker network create sandman-edge --scope swarm -d overlay && \
docker network create sandman-services --scope swarm -d overlay
echo " -> Docker Swarm Configured!"

echo "########################################################################"
echo "Configure Traefik..."
echo "########################################################################"
mkdir traefik && \
touch ./traefik/acme.json && \
chmod 600 ./traefik/acme.json && \
read -p "Email for letsencrypt notification (Eg. user@domain.com): " EMAIL_LETSENCRYPT </dev/tty
read -p "Domain (Eg. domain.com): " SERVER_DOMAIN </dev/tty
read -p "Use DNS-01 challenge (support only godaddy domains) [y/n]: " DNS_CHALLENGE </dev/tty
if [[ $DNS_CHALLENGE == "y" || $DNS_CHALLENGE == "Y" ]];
then
    echo "API Key:"
    read API_KEY
    echo "API Secret:"
    read API_SECRET
    cat << EOF > ./traefik/traefik.toml
debug = true

logLevel = "INFO"
defaultEntryPoints = ["https","http"]

[entryPoints]
  [entryPoints.http]
  address = ":80"
    [entryPoints.http.redirect]
    entryPoint = "https"
  [entryPoints.https]
  address = ":443"
  [entryPoints.https.tls]

[retry]

[docker]
endpoint = "unix:///var/run/docker.sock"
domain = "docker.localhost"
watch = true
swarmMode = true

[acme]
email = "${EMAIL_LETSENCRYPT}"
storage = "acme.json"
acmeLogging = true
entryPoint = "https"

[acme.dnsChallenge]
  provider = "godaddy"
  delayBeforeCheck = 0

[[acme.domains]]
  main = "*.${SERVER_DOMAIN}"
[[acme.domains]]
  main = "${SERVER_DOMAIN}"
EOF

else
 cat << EOF > ./traefik/traefik.toml
debug = true

logLevel = "INFO"
defaultEntryPoints = ["https","http"]

[entryPoints]
  [entryPoints.http]
  address = ":80"
    [entryPoints.http.redirect]
    entryPoint = "https"
  [entryPoints.https]
  address = ":443"
  [entryPoints.https.tls]

[retry]

[docker]
endpoint = "unix:///var/run/docker.sock"
domain = "docker.localhost"
watch = true
swarmMode = true

[acme]
email = "${EMAIL_LETSENCRYPT}"
storage = "acme.json"
onHostRule = true
acmeLogging = true
entryPoint = "https"

[acme.httpChallenge]
  entryPoint = "http"

EOF

fi

cat << EOF > ./traefik/docker-compose.yml
version: "3.7"
services:
  edge-traefik:
    image: traefik:1.7-alpine
    environment:
      - GODADDY_API_KEY=\${KEY}
      - GODADDY_API_SECRET=\${SECRET}
    ports:
      - 80:80
      - 443:443
      - 8080:8080
    volumes:
      - /run/docker.sock:/var/run/docker.sock
      - ./traefik/acme.json:/acme.json
      - ./traefik/traefik.toml:/etc/traefik/traefik.toml
    deploy:
      labels:
        - traefik.enable=false
      placement:
        constraints:
        - node.role == manager
      mode: global
      restart_policy:
        condition: any
        delay: 15s
        max_attempts: 30    
    networks:
      - sandman-edge
      - sandman-services

networks:
  sandman-edge:
    name: sandman-edge
    external: true
  sandman-services:
    name: sandman-services
    external: true

EOF

KEY=$API_KEY SECRET=$API_SECRET docker stack deploy -c ./traefik/docker-compose.yml traefik && \
echo "########################################################################"  && \
echo " -> Traefik with let's encrypt configured and started"  && \
echo "########################################################################"
