#!/bin/bash
apt install vim
apt install vi
apt install curl
apt install ssh
apt install aptitude
apt dist-upgrade
apt install php
apt install php curl
apt-get install php-curl
apt install wget
apt-get install php-curl
apt install dpkg
apt install get
apt install ssh 
apt install gnupg
apt-get install apache1
apt-get install composer
apt update
apt install httpd
#....................install php 7 on debian............. 

apt-get update
apt-get install apt-transport-https lsb-release ca-certificates
wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
sh -c 'echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list'
apt-get update
apt-get install php7.4
apt-get install -f php7.4-mysql php7.4-mbstring php7.4-xml php7.4-bcmath php7.4-curl php7.4-gd php7.4-zip
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer
chmod +x /usr/local/bin/composer
git clone https://github.com/laravel/laravel.git
cd /var/www/laravel
composer install
chown -R www-data.www-data /var/www/laravel
chmod -R 755 /var/www/laravel
chmod -R 777 /var/www/laravel/storage

#......................install git...........
apt update
apt-get install g
git -y

#.......................mysql......
apt install gnupg
cd /tmp
wget https://dev.mysql.com/get/mysql-apt-config_0.8.13-1_all.deb
dpkg -i mysql-apt-config_0.8.13-1_all.deb
apt-get update
apt-get install mysql-community-server
systemctl status mysql.service
aptitude install mariadb-server
#................setup laravel.......
apt update
apt install mariadb-server mariadb-client
systemctl status mariadb
#etc
