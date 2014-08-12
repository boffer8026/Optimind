#!bin/bash

# cd in and setup storage
cd $2
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

