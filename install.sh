#!/bin/bash 

apt-get update && \
apt-get upgrade && \

read -p "Install Google Authenticator [y/n]" GA
read -p "Install ufw Firewall [y/n]" UFW
read -p "Install docker-swarm-traefik-letsencrypt [y/n]" DOCKER
read -p "Install gitlab-runner [y/n]" GR
