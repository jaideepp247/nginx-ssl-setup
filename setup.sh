#!/bin/bash

# Ask for user input
read -p "Enter your domain name (e.g., example.com): " DOMAIN
read -p "Enter the port your app is running on (e.g., 5000): " PORT
read -p "Enter your email for SSL certificate registration: " EMAIL

echo "Updating system..."
sudo apt update -y && sudo apt upgrade -y

echo "Installing Nginx and Certbot..."
sudo apt install -y nginx certbot python3-certbot-nginx

echo "Configuring Nginx for $DOMAIN on port $PORT..."
NGINX_CONF="/etc/nginx/sites-available/$DOMAIN"

# Create Nginx configuration
sudo tee $NGINX_CONF > /dev/null <<EOL
server {
    listen 80;
    server_name $DOMAIN;

    location / {
        proxy_pass http://127.0.0.1:$PORT;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
    }
}
EOL

echo "Enabling Nginx site configuration..."
sudo ln -sf $NGINX_CONF /etc/nginx/sites-enabled/
sudo systemctl restart nginx

echo "Obtaining SSL Certificate..."
sudo certbot --nginx -d $DOMAIN --email $EMAIL --agree-tos --non-interactive

echo "Setting up auto-renewal..."
echo "0 3 * * * root certbot renew --quiet" | sudo tee -a /etc/crontab > /dev/null

echo "Setup Complete! Visit: https://$DOMAIN"
