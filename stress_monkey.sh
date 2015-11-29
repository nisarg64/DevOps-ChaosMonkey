#!/bin/bash
echo "------------------------------------------------------------------------------------------------"
echo "Stress Monkey Started"
home="/home/nisarg/devopsProject/greenhouse"
cd $home
file="stress-config"
line=$(((($RANDOM + $RANDOM) % 9) + 1))
stresscmd=`sed $line'!d' $file`
echo "Stress Command: $stresscmd"
stressoutput=`$stresscmd`
uptime=`uptime`
START=$(($(date +%s%N)/1000000))
cmd=`curl -s -o /dev/null -w "%{http_code}" localhost:8080`
END=$(($(date +%s%N)/1000000))
DIFF=$(( $END - $START ))
if [ $DIFF -gt 5 ]; then
	echo -e "Curl Request to Application Greenhouse took $DIFF milliseconds! \n\n Following is the stress test metric:\n\n $uptime \n" | mailx -s "(WARNING)Stress Monkey Update" ndgandh2@ncsu.edu
else
	echo -e "Curl Request to Application Greenhouse took $DIFF milliseconds! \n\n Following is the stress test metric:\n\n $uptime \n" | mailx -s "Stress Monkey Update" ndgandh2@ncsu.edu
fi 
echo "------------------------------------------------------------------------------------------------"