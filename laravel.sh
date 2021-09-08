#!/bin/bash

export APPNAME=myapp
export APPFQDN=$APPNAME.com

apt update
apt upgrade -y

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
composer -V
composer global require laravel/installer

echo "export PATH='$HOME/.config/composer/vendor/bin:$PATH'" >> ~/.bashrc

source ~/.bashrc

laravel new /home/techblog/$APPNAME
chgrp -R www-data /home/techblog/$APPNAME
chmod -R 775 /home/techblog/$APPNAME/storage
cd /etc/apache2/sites-available/

cat << EOF > $APPFQDN.conf
<VirtualHost *:80>
    ServerName $APPFQDN.com
    ServerAdmin admin@$APPFQDN
    DocumentRoot /home/techblog/$APPNAME/public

    <Directory /home/techblog/$APPNAME/public>
        Options Indexes MultiViews
        AllowOverride None
        Require all granted
    </Directory>

    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
EOF

a2enmod rewrite
a2ensite $APPFQDN.conf
systemctl restart apache2
