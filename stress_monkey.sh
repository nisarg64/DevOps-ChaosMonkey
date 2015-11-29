#!/bin/bash
echo "------------------------------------------------------------------------------------------------"
echo "Stress Monkey Started"
PRJ_HOME=`cat config.cfg | grep PROJECT_HOME | cut -d '=' -f2`
EMAIL_REC=`cat config.cfg | grep EMAIL_LIST | cut -d '=' -f2`
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
	echo -e "Curl Request to Application Greenhouse took $DIFF milliseconds! \n\n Following is the stress test metric:\n\n $uptime \n" | mailx -s "(WARNING)Stress Monkey Update" $EMAIL_REC
else
	echo -e "Curl Request to Application Greenhouse took $DIFF milliseconds! \n\n Following is the stress test metric:\n\n $uptime \n" | mailx -s "Stress Monkey Update" $EMAIL_REC
fi
echo "------------------------------------------------------------------------------------------------"