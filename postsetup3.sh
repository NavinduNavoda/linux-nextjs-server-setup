#!/bin/bash

# Check if the correct number of arguments are provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <DOMAIN>"
    exit 1
fi

# Variables from arguments
DOMAIN=$1

# Install Nginx
sudo apt install nginx -y

# Allow Nginx in firewall
sudo ufw allow 'Nginx Full'

# Remove the default configuration file
sudo rm /etc/nginx/sites-available/default
sudo rm /etc/nginx/sites-enabled/default

# Configure Nginx for your domain
sudo bash -c "cat <<'EOF' > /etc/nginx/sites-available/$DOMAIN
server {
    listen 80;
    listen [::]:80;

    root /var/www/html;
    index index.html index.htm index.nginx-debian.html;

    server_name $DOMAIN www.$DOMAIN;

    client_max_body_size 100M;
    client_body_timeout 60s;

    # Route /admin to localhost:4000 (Node.js Express API)
    location /api {
        proxy_pass http://localhost:8080;
        proxy_http_version 1.1;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
        proxy_cache_bypass \$http_upgrade;
    }

    # Route all other requests to localhost:3000
    location / {
        proxy_pass http://localhost:3000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
        proxy_cache_bypass \$http_upgrade;
    }
}
EOF"

# Enable the Nginx configuration
sudo ln -s /etc/nginx/sites-available/$DOMAIN /etc/nginx/sites-enabled/

# Uncomment server_names_hash_bucket_size in nginx config
sudo sed -i 's/# server_names_hash_bucket_size 64;/server_names_hash_bucket_size 64;/' /etc/nginx/nginx.conf

# Test Nginx configuration
sudo nginx -t

# Reload Nginx to apply the configuration
sudo systemctl restart nginx

# Install Certbot for SSL
snap install certbot --classic
sudo apt-get update -y
sudo apt install certbot python3-certbot-nginx -y

# Obtain and install SSL certificate
sudo certbot --nginx -d $DOMAIN -d www.$DOMAIN

# Renew automatically
sudo certbot renew --dry-run

# Reload Nginx to apply the SSL configuration
sudo systemctl restart nginx
