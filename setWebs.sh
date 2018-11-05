#!/bin/bash

systemctl restart httpd
echo 'Starting Provision: web'$1
sudo rm -rf /var/www/html/index.html
sudo touch /var/www/html/index.html
#echo "<h1>Epta!</h1>" >> /var/www/html/index.html
echo "Machine: work$1" >> /var/www/html/index.html
#echo 'Provision work'$1 'complete'
