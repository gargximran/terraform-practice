#!/bin/bash
apt update
apt install nginx -y
echo "$(hostname -f)" > /var/www/html/index.html