OptiMind Dev Environment
========================


Grab the box
------------
`vagrant box add laravel/homestead --box-version 0.1.9`


Add optimind.app to your hosts
------------------------------
`vi /etc/hosts`
127.0.0.1  optimind.app
`dscacheutil -flushcache; sudo killall -HUP mDNSResponder`


Install composer globally
-------------------------
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /bin/composer


Install envoy globally
----------------------
composer global require "laravel/envoy=~1.0"


Install beanstalkd console project
----------------------------------
composer create-project ptrofimov/beanstalk_console -s dev


Export OPTIMIND_SITE env var
----------------------------
This will map to /home/vagrant/optimind-site on the vm.
**Make sure to adjust to be where the optimind-site repo is on your machine.**
**Make sure to change ~/.profile to whatever shell you're using if not default mac os x.**

`echo 'export OPTIMIND_SITE=/your/local/path/to/optimind-site' >> ~/.profile`
`echo 'export BEANSTALK_CONSOLE=/your/local/path/to/beanstalk_console' >> ~/.profile`


Start & auto-provision the box
------------------------------
`vagrant up`


Run guard on local machine
--------------------------
`bundle install`
`guard`

Alias your shiny new vm!
------------------------
`echo "alias devoptimind='ssh vagrant@127.0.0.1 -p 2222'" >> ~/.profile`


SSH in
------
devoptimind


Access the vm!
--------------
[http://optimind.app:8000](http://optimind.app:8000)

or

[https://optimind.app:4443](https://optimind.app:4443) if you wanna be fancy ;)


If you need to reprovision:
---------------------------
`vagrant reload --provision`




