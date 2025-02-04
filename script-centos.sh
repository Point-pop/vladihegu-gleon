#!/bin/bash

yum update -y
yum install git ufw -y

ufw allow 22
ufw --force enable
ufw status

yum install nginx -y

service nginx status | grep 'enabled;' 
service ufw status |grep 'enabled;'

ufw allow 80
ufw status

#curl localhost:80

service nginx stop
yum install httpd -y
cp page1.html /var/www/html/vladihegu.html
yum install php -y

cp lola.php /var/www/html/lola.php

yum install mysql-server -y

mysql -e "CREATE DATABASE wordpress"
mysql -e "CREATE USER 'wp_user'@'localhost' IDENTIFIED BY 'password';"
mysql -e "GRANT ALL PRIVILEGES ON * . * TO 'wp_user'@'localhost';"
mysql -e "FLUSH PRIVILEGES;"

service mysql status

mysql -e "show DATABASES;"
mysql -e "SELECT user FROM mysql.user;"

wget -O /var/www/latest.tar.gz https://wordpress.org/latest.tar.gz
tar -xzvf /var/www/latest.tar.gz -C /var/www/
cp wp-config.php /var/www/wordpress/wp-config.php
mv /var/www/wordpress/ /var/www/html/wordpress/

sudo yum install php-mysqlnd -y

service httpd restart