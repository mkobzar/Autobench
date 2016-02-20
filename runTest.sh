#!/bin/bash
domain="www.example.com" 
paths=(
"/"
)
mkdir -p $HOME/testResults/
cd $HOME/testResults/
for ix in ${!paths[*]}  
do
	low_rate=5
	high_rate=100
	rate_step=5
	num_call=2
	num_conn=0
	timeout=15
	path="${paths[$ix]}"
	for i in $(seq 1 6) 
		do 
		num_call=`expr $num_call \\* 2`
		num_conn=`expr $num_conn \\+ 100`
		testName="LR="$low_rate"_HR="$high_rate"_RS="$rate_step"_Call="$num_call"_Conn="$num_conn"_TO="$timeout
		fileName=$(echo ${path%%begining_of_the_string_to_remove*} | tr -dc '[[:alpha:]][[:digit:]]')"_"$testName"_"$(date +%Y_%m_%d_%H_%M_%S)
		echo "testing url = "$domain$path > $fileName".txt"
		sudo autobench --single_host --port1=443 --httperf_ssl NULL --low_rate $low_rate --high_rate $high_rate --rate_step $rate_step --num_call $num_call --num_conn $num_conn --timeout $timeout --host1 $domain --uri1 $path --file $fileName".csv" >> $fileName".txt" 
		sudo bench2graph $fileName".csv" $fileName"_rates.jpeg" ${path%%access_token*} 2 5 6 7 8
		sudo bench2graph $fileName".csv" $fileName"_replies.jpeg" ${path%%access_token*} 11 12 13 14 15 17
		sudo bench2graph $fileName".csv" $fileName"_resp_time.jpeg" ${path%%access_token*} 10
		sleep 2; 
	done 
done

		
#httperf --timeout=120 --client=0/1 --server=$domain  --port=443 --uri=$path --rate=1 --ssl --ssl-protocol=auto --num-conns=1 --num-calls=1 --print-reply=[SB]