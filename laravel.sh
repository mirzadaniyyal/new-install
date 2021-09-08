#!/bin/bash
apt update
apt install apache2
systemctl start apache2
apt install libapache2-mod-php php php-common php-xml php-gd php-opcache php-mbstring php-tokenizer php-json php-bcmath php-zip unzip
cd /etc/php/7.4/apache2
nano php.ini
cd ~
systemctl restart apache2
apt install curl
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer
composer global require laravel/installer
nano ~/.bashrc
source ~/.bashrc
echo $PATH
laravel new myapp1
chgrp -R www-data /home/techblog/myapp1
chmod -R 775 /home/techblog/myapp1/storage
cd /etc/apache2/sites-available/
nano myapp1.com.conf
<VirtualHost *:80>
    ServerName myapp1.com

    ServerAdmin admin@myapp1.com
    DocumentRoot root/myapp1/public

    <Directory /root/myapp1>
        Options Indexes MultiViews
        AllowOverride None
        Require all granted
    </Directory>

    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>

#All Red colored text must be changed as per your//
a2enmod rewrite.
a2ensite myapp1.com.conf.
systemctl restart apache2
nano /etc/hosts 
127.0.0.1   myapp1.com





