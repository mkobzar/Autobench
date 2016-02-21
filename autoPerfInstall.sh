sudo apt-get update
sudo apt-get -q -y install ruby
sudo apt-get -q -y install autoconf
sudo apt-get -q -y install libtool

mkdir $HOME/git
cd $HOME/git
git clone https://github.com/httperf/httperf.git
cd httperf
sudo mkdir m4
sudo autoreconf -i
sudo mkdir build
cd build
sudo ../configure
sudo make
sudo make install
cd
sudo gem install httperfrb
sudo gem install autoperf
sudo gem install bundler
echo 'gem "autoperf"' >> Gemfile
sudo bundle install
bundle exec autoperf -c autoPerfSampleJsonFewFields.yml > sampleJsonFew.json
bundle exec autoperf -c autoPerfSampleCsvAllFields.yml > sampleJsonFull.csv
bundle exec autoperf -c autoPerfSampleCsvFewFields.yml > sampleJsonFew.csv
bundle exec autoperf -c autoPerfSampleConsoleFewFields.yml
