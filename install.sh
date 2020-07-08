#!/bin/bash 

apt-get update && apt-get upgrade

read -p "Install Google Authenticator [y/n]" GA
if [[ $GA == "y" || $GA == "Y" ]];
then
    curl https://raw.githubusercontent.com/jairsjunior/vps-setup/master/ga.sh | bash
fi
read -p "Install ufw Firewall [y/n]" UFW
if [[ $UFW == "y" || $UFW == "Y" ]];
then
    curl https://raw.githubusercontent.com/jairsjunior/vps-setup/master/ufw.sh | bash    
fi
read -p "Install docker-swarm-traefik-letsencrypt [y/n]" DOCKER
if [[ $DOCKER == "y" || $DOCKER == "Y" ]];
then
    curl https://raw.githubusercontent.com/jairsjunior/vps-setup/master/docker-traefik-letsencrypt.sh | bash
fi
read -p "Install gitlab-runner [y/n]" GR
if [[ $GR == "y" || $GR == "Y" ]];
then
    curl https://raw.githubusercontent.com/jairsjunior/vps-setup/master/gitlab-runner.sh | bash
fi

