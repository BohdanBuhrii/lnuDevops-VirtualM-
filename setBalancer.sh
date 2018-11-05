#!/bin/bash

echo 'Starting Provision: lnu1810devops_3'
sudo service nginx stop
sudo rm /etc/nginx/nginx.conf #!!!!!!!!!!!!!!!!!!
sudo ls -s /etc/nginx/sites-enabled/default #
echo "upstream testapp {
        server 1.168.33.101;
        server 1.168.33.102;
}

server {
        listen 80 default_server;
        listen [::]:80 default_server ipv6only=on;

        root /usr/share/nginx/html;
        index index.html index.htm;

        # Make site accessible from http://localhost/
        server_name localhost;

        location / {
                proxy_pass http://testapp;
        }
}" >> /etc/nginx/sites-enabled/default #
sudo service nginx start
echo "Machine: lb1" >> /usr/share/nginx/html/index.html
echo 'Provision lb1 complete'
