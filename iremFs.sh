#!/bin/bash

yum -y insyall screen 

cd /usr/local/src

screen_name=$"log"
screen -dmS $screen_name

cmd=$"curl -s https://raw.githubusercontent.com/ghosts1995/ops/master/install/iyfs1-10.sh | bash";
screen -x -S $screen_name -p 0 -X stuff "$cmd"
screen -x -S $screen_name -p 0 -X stuff $'\n'

echo "done"
