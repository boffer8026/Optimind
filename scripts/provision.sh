#!bin/bash

# set the local OPITMIND_SITE env
echo 'export OPTIMIND_SITE=/home/vagrant/optimind-site' >> ~/.bashrc
source ~/.bashrc

# cd into app directory
cd $2

# and setup storage
mkdir -p app/storage/cache
mkdir -p app/storage/guard
mkdir -p app/storage/logs
mkdir -p app/storage/meta
mkdir -p app/storage/sessions
mkdir -p app/storage/views
chmod -R 777 app/storage

# install packages
composer install

# setup the db
mysql -u root -psecret -e 'DROP USER laravel@localhost;'
mysql -u root -psecret -e 'DROP DATABASE optimind_laravel;'
mysql -u root -psecret -e 'CREATE DATABASE optimind_laravel;'
mysql -u root -psecret -e 'CREATE USER laravel@localhost IDENTIFIED BY "1234";'
mysql -u root -psecret -e 'GRANT ALL ON optimind_laravel.* TO laravel@localhost IDENTIFIED BY "1234";'

# run migrations
php artisan migrate:install
php artisan migrate
php artisan db:seed

# copy self-signed ssl certs
mkdir -p "/etc/nginx/ssl/$1"
sudo cp "$4/$1.crt" "/etc/nginx/ssl/$1/$1.crt"
sudo cp "$4/$1.key" "/etc/nginx/ssl/$1/$1.key"

# copy nginx site conf
sudo cp $3 /etc/nginx/sites-available/$1

# symlink to sites-enabled
ln -fs "/etc/nginx/sites-available/$1" "/etc/nginx/sites-enabled/$1"

# restart
service nginx restart
service php5-fpm restart

# symlink assets to public in dev
cd $2/public
ln -nfs "../app/assets/images" "images"
ln -nfs "../app/assets/css" "css"
ln -nfs "../app/assets/js" "js"
ln -nfs "../app/assets/fonts" "fonts"

# install phpunit globally
wget https://phar.phpunit.de/phpunit.phar
chmod +x phpunit.phar
sudo mv phpunit.phar /usr/local/bin/phpunit

# make supervisor start on reboot
sudo cp /home/vagrant/optimind-site/config/supervisor/rc.local /etc/rc.local
sudo chmod +x /etc/rc.local

# copy supervisor queue config
sudo cp /home/vagrant/optimind-site/config/supervisor/queue.conf /etc/supervisor/conf.d/queue.conf

# start the supervisor config
sudo supervisorctl reread
sudo supervisorctl add queue

