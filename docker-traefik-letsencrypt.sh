#!/bin/bash

echo "########################################################################"
echo "# This file configure the instalation and configuration of:            #"
echo "# -> Docker                                                            #"
echo "# -> Swarm                                                             #"
echo "########################################################################"

echo "Instaling docker..."
apt-get update && \
apt-get install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common && \
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - && \
apt-key fingerprint 0EBFCD88 && \
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" && \
apt-get update && \
apt-get install -y docker-ce docker-ce-cli containerd.io && \
touch /.dockerenv && \
echo "{ \"iptables\": true, \"log-driver\": \"journald\" }" > /etc/docker/daemon.json && \
service docker restart && \
echo " -> Docker Installed and Configured!"

sleep 5

echo "Configure Swarm..."
docker swarm init && \
docker network create sandman-edge --scope swarm -d overlay && \
docker network create sandman-services --scope swarm -d overlay
echo " -> Docker Swarm Configured!"

# echo "Configure Traefik..."
# echo "Email for letsencrypt notification (Eg. user@domain.com):"
# read EMAIL_LETSENCRYPT
# echo "Domain (Eg. domain.com):"
# read SERVER_DOMAIN
# echo "Use DNS-01 challenge (support only godaddy domains) (y/n):"
# read DNS_CHALLENGE
# if [ $DNS_CHALLENGE == "y" || $DNS_CHALLENGE == "Y"];
# then
#     echo "API Key:"
#     read API_KEY
#     echo "API Secret:"
#     read API_SECRET
#     sed 
# else

# fi



