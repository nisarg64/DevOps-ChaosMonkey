#!/bin/bash
rno=$RANDOM
echo "Random Number: $rno"
home="/home/nisarg/devopsProject/greenhouse"
cd $home
remainder=`expr $rno % 2`
if [ $remainder -eq 0 ]; then
	./restart_monkey.sh
else
	./stress_monkey.sh
fi