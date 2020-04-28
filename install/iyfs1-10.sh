#!/bin/bash

yum -y install epel-release 
yum -y update
yum -y install wget bind-utils jwhois mtr traceroute tcpdump tshark
yum install -y https://files.freeswitch.org/repo/yum/centos-release/freeswitch-release-repo-0-1.noarch.rpm
yum install -y freeswitch-config-vanilla freeswitch-lang-* freeswitch-sounds-*

rpm -ivh https://files.freeswitch.org/repo/yum/centos-release/7/x86_64/freeswitch-xml-curl-1.10.2.release.4-1.el7.x86_64.rpm
rpm -ivh https://files.freeswitch.org/repo/yum/centos-release/7/x86_64/freeswitch-event-format-cdr-1.10.2.release.4-1.el7.x86_64.rpm

systemctl enable freeswitch

curl -s https://raw.githubusercontent.com/ghosts1995/ops/master/install/igit.sh | bash && source /etc/bashrc && git --version

serverId=$(sed -n 1p /var/log/voip.log)
serverAddr=$(sed -n 1p /var/log/voipAddr.log)

echo $serverId
echo $serverAddr

rm -rf /etc/freeswitch/vars.xml
# vars=$(curl -s "$serverAddr/api/v1/server/cfg?id=$serverId&file=vars")
curl -o /etc/freeswitch/vars.xml "$serverAddr/init/$serverId/vars"

rm -rf /etc/freeswitch/autoload_configs/modules.conf.xml
# modules=$(curl -s "$serverAddr/api/v1/server/cfg?id=$serverId&file=modules")
curl -o /etc/freeswitch/autoload_configs/modules.conf.xml "$serverAddr/init/$serverId/modules"

rm -rf /etc/freeswitch/autoload_configs/format_cdr.conf.xml
# cdr=$(curl -s "$serverAddr/api/v1/server/cfg?id=$serverId&file=cdr")
curl -o /etc/freeswitch/autoload_configs/format_cdr.conf.xml "$serverAddr/init/$serverId/cdr"

rm -rf /etc/freeswitch/autoload_configs/xml_curl.conf.xml
curl -o /etc/freeswitch/autoload_configs/xml_curl.conf.xml "$serverAddr/init/$serverId/curl"


rm -rf /etc/freeswitch/autoload_configs/event_socket.conf.xml
curl -o /etc/freeswitch/autoload_configs/event_socket.conf.xml "$serverAddr/init/$serverId/es"


echo "install done"

curl -s "$serverAddr/init/$serverId/install"

chown -R freeswitch:daemon /etc/freeswitch

systemctl start freeswitch
