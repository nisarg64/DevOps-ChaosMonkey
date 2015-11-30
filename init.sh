#!/bin/bash

HOST1=`cat config.cfg | grep SERVER1 | cut -d '=' -f2`
HOST2=`cat config.cfg | grep SERVER2 | cut -d '=' -f2`

# scp the monkey scripts to both the hosts
scp -o "StrictHostKeyChecking no" restart_monkey.sh root@$HOST1:~/restart_monkey.sh
scp -o "StrictHostKeyChecking no" stress_monkey.sh root@$HOST1:~/stress_monkey.sh
scp -o "StrictHostKeyChecking no" chaos_monkey.sh root@$HOST1:~/chaos_monkey.sh
scp -o "StrictHostKeyChecking no" config.cfg root@$HOST1:~/config.cfg
scp -o "StrictHostKeyChecking no" stress-config root@$HOST1:~/stress-config

ssh -o "StrictHostKeyChecking no" -t root@$HOST1 "chmod +x ~/restart_monkey.sh"
ssh -o "StrictHostKeyChecking no" -t root@$HOST1 "chmod +x ~/stress_monkey.sh"
ssh -o "StrictHostKeyChecking no" -t root@$HOST1 "chmod +x ~/chaos_monkey.sh"

scp -o "StrictHostKeyChecking no" restart_monkey.sh root@$HOST2:~/restart_monkey.sh
scp -o "StrictHostKeyChecking no" stress_monkey.sh root@$HOST2:~/stress_monkey.sh
scp -o "StrictHostKeyChecking no" chaos_monkey.sh root@$HOST2:~/chaos_monkey.sh
scp -o "StrictHostKeyChecking no" config.cfg root@$HOST2:~/config.cfg
scp -o "StrictHostKeyChecking no" stress-config root@$HOST2:~/stress-config

ssh -o "StrictHostKeyChecking no" -t root@$HOST2 "chmod +x ~/restart_monkey.sh"
ssh -o "StrictHostKeyChecking no" -t root@$HOST2 "chmod +x ~/stress_monkey.sh"
ssh -o "StrictHostKeyChecking no" -t root@$HOST2 "chmod +x ~/chaos_monkey.sh"


# Prepare the cron job 
WORKING_DIR=`pwd`
if [ -f $WORKING_DIR/crontab.txt ]
then
rm $WORKING_DIR/crontab.txt
fi
echo "*/1 * * * * $WORKING_DIR/chaos_monkey.sh >> $WORKING_DIR/cronjob.out" > crontab.txt
