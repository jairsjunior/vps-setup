#!/bin/bash

echo "########################################################################"
echo "# This file configure the instalation and configuration of:            #"
echo "# -> 2FA using Google Authenticator for ssh connections at 2222 port   #"
echo "# -> Firewall using ufw to only permit use of 2222/80/443 ports        #"
echo "########################################################################"       

echo "Installing 2FA.."

echo "Installing libpam-google-authenticator.."
apt-get update && apt-get install -y libpam-google-authenticator && \
echo "Configure sshd service" && \
echo "auth required pam_google_authenticator.so" >> /etc/pam.d/sshd && \
sed -i 's/ChallengeResponseAuthentication no/ChallengeResponseAuthentication yes/g' /etc/ssh/sshd_config && \
sed -i 's/#Port 22/Port 2222/g' /etc/ssh/sshd_config && \
service sshd restart && \
echo "Configure the google_authenticator..." && \
google_authenticator

echo "Installing ufw.."
apt-get update && apt-get install -y ufw && \
echo "Configure ufw to accept only incoming calls from 2222,80,443..."
ufw default deny incoming && \
ufw default allow outgoing && \
ufw allow 2222 && \
ufw allow 80 && \
ufw allow 443 && \
ufw enable


