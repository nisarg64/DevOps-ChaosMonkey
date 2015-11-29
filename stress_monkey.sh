#!/bin/bash
stressoutput=`stress-ng --cpu 4 --io 2 --vm 1 --vm-bytes 1G --timeout 60s --metrics-brief`
uptime=`uptime`
START=$(($(date +%s%N)/1000000))
cmd=`curl -s -o /dev/null -w "%{http_code}" localhost:8080`
END=$(($(date +%s%N)/1000000))
DIFF=$(( $END - $START ))
if [ $DIFF -gt 5 ]; then
	echo -e "Curl Request to Application GreenHouse took $DIFF milliseconds! \n\n Following is the stress test metric:\n\n $uptime \n" | mailx -s "(WARNING)Stress Monkey Update" ndgandh2@ncsu.edu
else
	echo -e "Curl Request to Application GreenHouse took $DIFF milliseconds! \n\n Following is the stress test metric:\n\n $uptime \n" | mailx -s "Stress Monkey Update" ndgandh2@ncsu.edu
fi 