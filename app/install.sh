#!/bin/bash
apt update -y
apt install nginx -y
echo "Hello from DevOps Project" > /var/www/html/index.html
systemctl start nginx
systemctl enable nginx