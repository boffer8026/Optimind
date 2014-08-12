OptiMind Dev Environment 
========================

Grab the box
------------
`vagrant box add laravel/homestead`


Add optimind.app to your hosts
------------------------------
`vi /etc/hosts`
127.0.0.1  optimind.app


Export OPTIMIND_SITE env var 
----------------------------
This will map to /home/vagrant/optimind-site on the vm.
Make sure to adjust to be where the optimind-site repo is on your machine:

`echo 'export OPTIMIND_SITE=~/Sites/optimind-site' >> ~/.profile`


Start & auto-provision the box
------------------------------
`vagrant up`


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




