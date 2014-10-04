# install ruby just for fun
\curl -L https://get.rvm.io | bash -s stable --ruby
source /home/vagrant/.rvm/scripts/rvm
bundle install
rvm rvmrc warning ignore /home/vagrant/optimind-site/Gemfile
rvm install ruby-2.1.2