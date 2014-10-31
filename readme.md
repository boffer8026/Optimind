OptiMind Dev Environment
========================

Grab the box
------------
`vagrant box add laravel/homestead --box-version 0.1.9`


Add optimind dev urls to your hosts
-----------------------------------
`vi /etc/hosts`

# optimind vm
192.168.10.10 optimind.app
192.168.10.10 optimind.test
192.168.10.10 optimind.workers
127.0.0.1 optimind.queue

`dscacheutil -flushcache;`


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
[https://optimind.app/](https://optimind.app/)


Watch your queues!
------------------
[http://optimind.workers/](http://optimind.workers/)

# add server
host: optimind.queue
port: 11300


If you need to reprovision:
---------------------------
`vagrant reload --provision`




