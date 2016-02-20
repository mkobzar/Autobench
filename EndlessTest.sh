#!/bin/bash
servers=("www.example.com")
paths=("/")
rate=25
num_call=50
num_conn=1000
timeout=15
cd
mkdir testResults
cd testResults
mkdir news
cd news

while :
do
	for ix in ${!paths[*]}  
	do
		path="${paths[$ix]}"
		for jx in ${!servers[*]}  
		do
			server="${servers[$jx]}"
			fileName=$(echo ${path%%begining_of_the_string_to_remove*} | tr -dc '[[:alpha:]][[:digit:]]')"_"$(date +%Y_%m_%d_%H_%M_%S)
			echo $fileName
			httperf --hog --server=$server  --port=443 --ssl --ssl-protocol=auto --uri=$path --num-conn=$num_conn --num-calls=$num_call --ra=$rate --timeout=$timeout | ruby -e 'require "httperf/parser"; require "json"; puts HTTPerf::Parser.parse(ARGF.read).to_json' > $fileName.json
 		done
	done 
	sleep 300;
done
