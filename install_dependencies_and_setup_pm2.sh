#!/bin/bash

# Check if the correct number of arguments are provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <PROJECT_DIRECTORY>"
    exit 1
fi

# Variables from arguments
PROJECT_DIRECTORY=$1

# Navigate to your project directory
cd $PROJECT_DIRECTORY

# Install project dependencies
npm install

# Build the Next.js application
npm run build

# Start the Next.js application with pm2
pm2 start npm --name "nextjs-app" -- run start

# Setup pm2 to start on boot
pm2 startup
pm2 save
