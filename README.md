# Ubuntu VPS Setup

Configure some usefull tools to your Ubuntu VPS machine:
1. SSH 2FA using Google Authenticator
1. Docker
1. Docker-compose
1. Docker Swarm
1. Traefik edge with Let's Encrypt
1. Gitlab Runner
1. Firewall using ufw [ inbound ports open 2222(ssh), 80, 443 ]

## Getting Started

- Login to your vps machine using the regular ssh command.
- If not exists, create a non root account at the sudoers group using this commands:

```
adduser nameOfYourNewUser

usermod -aG sudo nameOfYourNewUser
```

- This user will be used to connect using ssh with 2FA after the script execution
- Go to the root user using `sudo su`
- Execute this script to install and configure everything

```
curl -s https://raw.githubusercontent.com/jairsjunior/vps-setup/master/install.sh | bash
```
