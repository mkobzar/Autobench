
sudo apt-get -q -y install ruby
sudo gem install httperfrb
sudo git clone https://github.com/jmervine/httperfrb.git

results="./results2"
mkdir $results
server="www.example.com"
httperf --hog --server $server --uri="/" --num-conn 30 --ra 3 --timeout 300 | ruby -e 'require "httperf/parser"; require "json"; puts HTTPerf::Parser.parse(ARGF.read).to_json' > $results/example.json
