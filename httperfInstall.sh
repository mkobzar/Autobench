#!/bin/bash
sudo apt-get update
sudo apt-get -q -y install ruby
sudo apt-get -q -y install autoconf
sudo apt-get -q -y install libtool
sudo apt-get -q -y install make
mkdir $HOME/git
cd $HOME/git
sudo git clone https://github.com/mkobzar/httperfrb.git
cd httperfrb
sudo gem build httperfrb.gemspec
sudo gem install ./httperfrb-0.3.13.gem
cd 	
sudo gem install autoperf
sudo gem install bundler
echo 'gem "autoperf"' >> Gemfile
sudo bundle install
cd $HOME/git
sudo apt-get -q -y install openssl
sudo apt-get -q -y install libssl-dev
sudo git clone https://github.com/httperf/httperf.git
cd httperf
sudo mkdir m4
sudo autoreconf -i
sudo mkdir build
cd build
sudo ../configure
sudo make
sudo make install
cd
bundle exec autoperf -c autoPerfExample.yml > results.csv

httperf --hog --server www.example.com --ssl --print-reply=[SB] --print-reply=[SB] --ssl-protocol=auto
