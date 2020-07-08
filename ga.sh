#!/bin/bash

echo "########################################################################"
echo "# This file configure the instalation and configuration of:            #"
echo "# -> 2FA using Google Authenticator for ssh connections at 2222 port   #"
echo "########################################################################"       

echo "Installing libpam-google-authenticator.."
apt-get install -y libpam-google-authenticator
echo "Configure sshd service" && \
if ! grep -q "auth required pam_google_authenticator.so" "/etc/pam.d/sshd"; 
then
    echo "auth required pam_google_authenticator.so" >> /etc/pam.d/sshd
fi
sed -i 's/ChallengeResponseAuthentication no/ChallengeResponseAuthentication yes/g' /etc/ssh/sshd_config && \
sed -i 's/#Port 22/Port 2222/g' /etc/ssh/sshd_config && \
echo "Configure the google-authenticator..." && \
read -p "Create a new username:" USERNAME </dev/tty
adduser $USERNAME && \
usermod -aG sudo $USERNAME && \
sudo -H -u $USERNAME bash -c "google-authenticator -t -d -r 3 -R 30 -f -w 3"
service sshd restart && \
echo "########################################################################"  && \
echo " -> 2FA configured to user: $USERNAME"  && \
echo "########################################################################"

