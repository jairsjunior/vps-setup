#!/bin/bash

echo "########################################################################"
echo "# This file configure the instalation and configuration of:            #"
echo "# -> Install Gitlab Runner                                             #"
echo "########################################################################" 

mkdir -p gitlab-runner && \
read -p "Gitlab URL (Eg. http://gitlab.com):" GITLAB_URL </dev/tty && \
read -p "Gitlab Registration Token:" TOKEN </dev/tty && \
read -p "Gitlab Runner Name:" NAME </dev/tty && \
read -p "Gitlab Runner Tag List (separated by comma. Eg. runner-build, runner-release):" TAG_LIST </dev/tty && \
cat << EOF > ./gitlab-runner/docker-compose.yml
version: "3.5"
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

EOF

docker-compose -f ./gitlab-runner/docker-compose.yml up -d