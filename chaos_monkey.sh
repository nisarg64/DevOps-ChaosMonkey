#!/bin/bash
rno=$RANDOM
echo "Random Number: $rno"
PRJ_HOME=`cat config.cfg | grep PROJECT_HOME | cut -d '=' -f2`
remainder=`expr $rno % 2`
if [ $remainder -eq 0 ]; then
	./restart_monkey.sh
else
	./stress_monkey.sh
fi