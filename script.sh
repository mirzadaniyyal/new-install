#!/bin/bash
apt update && apt upgrade -y

apt install -y wget vim curl openssh-server git lynx

#.......................apache......
apt install -y apache2

#.......................mysql......
wget https://dev.mysql.com/get/mysql-apt-config_0.8.19-1_all.deb -C /tmp
dpkg -i /tmp/mysql-apt-config_0.8.19-1_all.deb
systemctl status mysql.service

#....................install php 7 on debian............. 

apt install -y apt-transport-https lsb-release ca-certificates
wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list

apt install -y php7.4 php7.4-mysql php7.4-mbstring php7.4-xml php7.4-bcmath php7.4-curl php7.4-gd php7.4-zip
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer
chmod +x /usr/local/bin/composer
git clone https://github.com/laravel/laravel.git
cd /var/www/laravel
composer install
chown -R www-data.www-data /var/www/laravel
chmod -R 755 /var/www/laravel
chmod -R 777 /var/www/laravel/storage
