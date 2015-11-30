#!/bin/bash
rno=$RANDOM
echo "Random Number: $rno"
PRJ_HOME=`cat config.cfg | grep PROJECT_HOME | cut -d '=' -f2`
remainder=`expr $rno % 2`

# Random number for hosts
rHost=$RANDOM
echo "Random Number for determining the host : $rHost"
remainderHost=`expr $rHost % 2`

# Select HOST
HOST=""

if [ $remainderHost -eq 0 ]; then
	HOST=`cat config.cfg | grep SERVER1 | cut -d '=' -f2`
else
	HOST=`cat config.cfg | grep SERVER2 | cut -d '=' -f2`
fi

# Select monkey to run
if [ $remainder -eq 0 ]; then
	ssh -t -o "StrictHostKeyChecking no" root@$HOST "./restart_monkey.sh"
else
	ssh -t -o "StrictHostKeyChecking no" root@$HOST "./stress_monkey.sh"
fi