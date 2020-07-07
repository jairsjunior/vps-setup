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
apt-get install docker-ce docker-ce-cli containerd.io

echo "Configure Swarm..."
docker swarm init && \
docker network create sandman-edge --scope swarm -d overlay && \
docker network create sandman-services --scope swarm -d overlay