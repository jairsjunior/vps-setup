#!/bin/bash

echo "########################################################################"
echo "# This file configure the instalation and configuration of:            #"
echo "# -> Install Gitlab Runner                                             #"
echo "########################################################################" 

mkdir gitlab-runner && \
read -p "Gitlab URL (Eg. http://gitlab.com):" GITLAB_URL && \
read -p "Gitlab Registration Token:" TOKEN && \
read -p "Gitlab Runner Name:" NAME && \
read -p "Gitlab Runner Tag List (separated by comma. Eg. runner-build, runner-release):" TAG_LIST && \
cat << EOF > ./gitlab-runner/docker-compose.yml
version: '3.5'
services:
  gitlab-runner:
    image: flaviostutz/gitlab-runner:ubuntu-v12.9.0.1
    volumes:
      - /run/docker.sock:/var/run/docker.sock
    environment:
      - GITLAB_URL=${GITLAB_URL}
      - REGISTRATION_TOKEN=${TOKEN}
      - NAME=${RUNNER_NAME}
      - TAG_LIST=${TAG_LIST}

EOF && \
docker-compose -f ./gitlab-runner/docker-compose.yml up -d