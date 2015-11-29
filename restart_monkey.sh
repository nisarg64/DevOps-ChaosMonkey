#!/bin/sh
echo "------------------------------------------------------------------------------------------------"
echo "Restart Monkey Started"
home="/home/nisarg/devopsProject/greenhouse"
cd $home
output=`ps aux|grep t7:run`
set -- $output
pid=$2
echo "Tomcat Process Id: $pid"
kill -9 $pid
echo "Killed the tomcar server. Restarting tomcat."
cmd="nohup mvn t7:run"
$cmd &
sleep 20
status=`curl -s -o /dev/null -w "%{http_code}" localhost:8080`
echo "Status of tomcat server is $status"
if [ $status != 200 ]; then
	echo "Tomcat Server Restart Failed" | mailx -s "(URGENT)Restart Monkey Update" ndgandh2@ncsu.edu
else
	echo "Tomcat Server Restart Passed" | mailx -s "Restart Monkey Update" ndgandh2@ncsu.edu
fi

echo "------------------------------------------------------------------------------------------------"