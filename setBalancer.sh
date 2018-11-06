#!/bin/bash

service nginx start

#Settings for nginx
echo 'Starting Provision: balancer'
sudo service nginx stop
sudo rm -rf /etc/nginx/nginx.conf
sudo touch /etc/nginx/nginx.conf

echo "
user nginx;
worker_processes auto;
error_log /var/log/nginx/error.log;
pid /run/nginx.pid;

include /usr/share/nginx/modules/*.conf;

events {
    worker_connections 1024;
}

http {
    log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                      '$status $body_bytes_sent "$http_referer" '
                      '"$http_user_agent" "$http_x_forwarded_for"';#

    access_log  /var/log/nginx/access.log  main;

    sendfile            on;
    tcp_nopush          on;
    tcp_nodelay         on;
    keepalive_timeout   65;
    types_hash_max_size 2048;

    include             /etc/nginx/mime.types;
    default_type        application/octet-stream;

    include /etc/nginx/conf.d/*.conf;
}" >> /etc/nginx/nginx.conf 

#settings for load-balancer
sudo rm -rf /etc/nginx/conf.d/load-balancer.conf
sudo touch /etc/nginx/conf.d/load-balancer.conf

echo "upstream testapp {
        server 1.168.1.101;
        server 1.168.1.102;
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
}" >> /etc/nginx/conf.d/load-balancer.conf
sudo service nginx start
echo "Machine: lnu1810devops_3" >> /usr/share/nginx/html/index.html
echo 'Provision balancer complete'