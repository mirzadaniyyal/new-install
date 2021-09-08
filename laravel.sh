#!/bin/bash

export APPNAME=myapp
export APPFQDN=$APPNAME.com

apt update
apt upgrade -y

apt install -y apache2 screen tree curl
systemctl start apache2
apt install -y libapache2-mod-php php php-common php-xml php-gd php-opcache php-mbstring php-tokenizer php-json php-bcmath php-zip unzip

PHPVERSION=`php -v | grep "PHP 7" | awk '{print substr($2,0,4)}'`

sed -i 's/cgi.fix_pathinfo=0/cgi.fix_pathinfo=1/g' /etc/php/$PHPVERSION/apache2/php.ini

systemctl restart apache2

curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer
composer global require laravel/installer

echo "export PATH='$HOME/.config/composer/vendor/bin:$PATH'" >> ~/.bashrc

source ~/.bashrc

cd /home/techblog

laravel new $APPNAME

chgrp -R www-data /home/techblog/$APPNAME/storage /home/techblog/$APPNAME/bootstrap/cache
chmod -R ug+rwx /home/techblog/$APPNAME/storage /home/techblog/$APPNAME/bootstrap/cache

cat << EOF > /etc/apache2/sites-available/$APPFQDN.conf
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
