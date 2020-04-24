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
