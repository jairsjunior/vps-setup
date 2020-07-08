#!/bin/bash 

apt-get update && apt-get upgrade

read -p "Install Google Authenticator [y/n]" GA </dev/tty
if [[ $GA == "y" || $GA == "Y" ]];
then
    curl https://raw.githubusercontent.com/jairsjunior/vps-setup/master/ga.sh -o ga.sh && bash ga.sh
fi
read -p "Install ufw Firewall [y/n]" UFW </dev/tty
if [[ $UFW == "y" || $UFW == "Y" ]];
then
    curl https://raw.githubusercontent.com/jairsjunior/vps-setup/master/ufw.sh -o ufw.sh && bash ufw.sh
fi
read -p "Install docker-swarm-traefik-letsencrypt [y/n]" DOCKER </dev/tty
if [[ $DOCKER == "y" || $DOCKER == "Y" ]];
then
    curl https://raw.githubusercontent.com/jairsjunior/vps-setup/master/docker-traefik-letsencrypt.sh -o docker-traefik-letsencrypt.sh && bash docker-traefik-letsencrypt.sh
fi
read -p "Install gitlab-runner [y/n]" GR </dev/tty
if [[ $GR == "y" || $GR == "Y" ]];
then
    curl https://raw.githubusercontent.com/jairsjunior/vps-setup/master/gitlab-runner.sh -o gitlab-runner.sh | bash gitlab-runner.sh
fi

