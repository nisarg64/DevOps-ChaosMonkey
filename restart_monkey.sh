#!/bin/bash
echo "------------------------------------------------------------------------------------------------"
echo "Restart Monkey Started"
PRJ_HOME=`cat config.cfg | grep PROJECT_HOME | cut -d '=' -f2`
EMAIL_REC=`cat config.cfg | grep EMAIL_LIST | cut -d '=' -f2`
WORKING_DIR=`pwd`
eval cd $PRJ_HOME
output=`ps aux|grep t7:run`
set -- $output
pid=$2
echo "Tomcat Process Id: $pid"
kill -9 $pid
echo "Killed the tomcar server. Restarting tomcat."
cmd="nohup mvn t7:run -Djava.security.egd=file:/dev/./urandom"
$cmd &
sleep 20
status=`curl -s -o /dev/null -w "%{http_code}" localhost:8080`
echo "Status of tomcat server is $status"
if [ $status != 200 ]; then
	echo "Tomcat Server Restart Failed" | mailx -s "(URGENT)Restart Monkey Update" $EMAIL_REC
else
	echo "Tomcat Server Restart Passed" | mailx -s "Restart Monkey Update" $EMAIL_REC
fi

echo "------------------------------------------------------------------------------------------------"
