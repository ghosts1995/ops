#!/bin/bash

touch /var/log/voip.log
touch /var/log/voipAddr.log

serverId=$1
echo $serverId > /var/log/voip.log

serverAddr=$2
echo $serverAddr > /var/log/voipAddr.log

file="/usr/bin/screen"

if [ ! -f $file ]; then
  yum -y insyall screen 
fi

cd /usr/local/src

screen_name=$"log"
screen -dmS $screen_name

cmd=$"curl -s https://raw.githubusercontent.com/ghosts1995/ops/master/install/iyfs1-10.sh | bash";
screen -x -S $screen_name -p 0 -X stuff "$cmd"
screen -x -S $screen_name -p 0 -X stuff $'\n'

echo $(sed -n 1p /var/log/voip.log)

echo "done"
