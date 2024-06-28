#!/bin/bash

# Install curl if not already installed
sudo apt install curl -y

# Download and install Node.js from NodeSource
curl -sL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt install -y nodejs

# Install pm2 globally
sudo npm install -g pm2

# Install TypeScript and Next.js globally
sudo npm install -g typescript next
