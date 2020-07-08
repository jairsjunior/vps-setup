#!/bin/bash

echo "########################################################################"
echo "# This file configure the instalation and configuration of:            #"
echo "# -> Firewall using ufw to only permit use of 2222/80/443 ports        #"
echo "########################################################################"       

apt-get install -y ufw && \
echo "Configure ufw to accept only incoming calls from 2222,80,443..."
ufw default deny incoming && \
ufw default allow outgoing && \
ufw allow 2222 && \
ufw allow 80 && \
ufw allow 443 && \
ufw enable && \
echo "########################################################################" && \
echo " -> ufw configured to accept requests only 2222,443,80" && \
echo "########################################################################"
