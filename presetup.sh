#!/bin/bash

# Update package list and upgrade all packages
sudo apt update && sudo apt upgrade -y

# Install UFW firewall
sudo apt install ufw -y

# Allow OpenSSH through the firewall
sudo ufw allow OpenSSH

# Enable the firewall
sudo ufw enable

# Create a 1GB swap file
sudo fallocate -l 1G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
sudo swapon --show

# Make the swap file permanent
echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab

# Install curl if not already installed
sudo apt install curl -y

# Download and install Node.js from NodeSource
curl -sL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt install -y nodejs

# Install pm2 globally
sudo npm install -g pm2

#install pnpm
sudo npm install -g pnpm


# Install TypeScript and Next.js globally
sudo npm install -g typescript next tsx

# Install Git
sudo apt install -y git

sudo ssh-keygen -t rsa -b 4096

# print out key to copy
cat /root/.ssh/id_rsa.pub



