#!/bin/bash
cd
sudo apt-get update
sudo apt-get -q -y install git
sudo apt-get -q -y install make
sudo apt-get -q -y install autoconf
sudo apt-get -q -y install libtool
sudo apt-get -q -y install libssl-dev
sudo apt-get -q -y install openssl
sudo apt-get -q -y install libevent-dev
sudo apt-get -q -y install unzip
sudo apt-get -q -y install gnuplot-x11
sudo apt-get -q -y install libcairo2-dev
sudo apt-get -q -y build-dep gawk
sudo apt-get -q -y install ruby
sudo gem install httperfrb
sudo git clone https://github.com/jmervine/httperfrb.git
#https://github.com/jmervine/httperfjs.git
#https://github.com/jmervine/autoperf.git
#https://www.igvita.com/2008/09/30/load-testing-with-log-replay/
sudo mkdir git
cd git
sudo rm -r httperf
sudo git clone https://github.com/jmervine/httperf.git
cd httperf
sudo mkdir m4
sudo autoreconf -i
sudo mkdir build
cd build
sudo ../configure
sudo make
sudo make install
cd
cd git
sudo rm -r Autobench
sudo git clone https://github.com/mkobzar/Autobench.git
cd Autobench
sudo make
sudo make install
sudo autobench --single_host --port1 443 --httperf_ssl NULL --low_rate 1 --high_rate 1 --rate_step 1 --num_call 1 --num_conn 1 --timeout 20 --host1 example.com --uri1 "/"
cd
