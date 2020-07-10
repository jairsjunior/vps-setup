#!/bin/bash 

apt-get update -y
apt-get upgrade -y

read -p "Install Google Authenticator [y/n]" GA </dev/tty
if [[ $GA == "y" || $GA == "Y" ]];
then
    curl -s https://raw.githubusercontent.com/jairsjunior/vps-setup/master/ga.sh | bash
fi
read -p "Install docker-swarm-traefik-letsencrypt [y/n]" DOCKER </dev/tty
if [[ $DOCKER == "y" || $DOCKER == "Y" ]];
then
    curl -s https://raw.githubusercontent.com/jairsjunior/vps-setup/master/docker-traefik-letsencrypt.sh | bash
fi
read -p "Install gitlab-runner [y/n]" GR </dev/tty
if [[ $GR == "y" || $GR == "Y" ]];
then
    curl -s https://raw.githubusercontent.com/jairsjunior/vps-setup/master/gitlab-runner.sh | bash
fi
read -p "Install ufw Firewall [y/n]" UFW </dev/tty
if [[ $UFW == "y" || $UFW == "Y" ]];
then
    curl -s https://raw.githubusercontent.com/jairsjunior/vps-setup/master/ufw.sh | bash
fi
