#!/bin/sh

output=`ps aux|grep t7:run`
set -- $output
pid=$2
echo "Tomcat Process Id: $pid"
kill $pid
echo "Killed the tomcar server. Restarting tomcat."
cmd="nohup mvn t7:run"
$cmd &
status=`curl -s -o /dev/null -w "%{http_code}" localhost:8080`
echo "Status of tomcat server is $status"
if [ $status != 200 ]; then
	echo "Greenhouse not restarted correctly!!"
else
	echo "Greenhouse restarted correctly!!"
fi