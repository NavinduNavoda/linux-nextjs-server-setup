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

# Make the swap file permanent
echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab
