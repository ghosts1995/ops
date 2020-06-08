#!/bin/bash

yum -y install epel-release 
yum -y update
yum -y install jwhois bind-utils tmux screen mtr traceroute tcpdump tshark

#wget -qO- https://raw.githubusercontent.com/ghosts1995/ops/master/install/igit.sh | bash && source /etc/bashrc && git --version


rm -rf /etc/profile.d/locale.sh

echo "export LC_CTYPE=en_US.UTF-8" >> /etc/profile.d/locale.sh
echo "export LC_ALL=en_US.UTF-8" >> /etc/profile.d/locale.sh

rm -rf /etc/locale.conf
echo "LANG=en_US.UTF-8" >> /etc/locale.conf


rm -rf  /etc/sysconfig/i18n
echo "LANG=en_US.UTF-8" >> /etc/sysconfig/i18n

rm -rf /etc/environment
echo "LANG=en_US.UTF-8" >> /etc/environment
echo "LC_ALL=en_US.UTF-8" >> /etc/environment


yum -y install ntp
systemctl enable ntpd 
systemctl start ntpd 
timedatectl set-timezone Asia/Singapore
timedatectl set-ntp yes
ntpq -p

date



# /etc/sysctl.conf
# net.ipv6.conf.all.disable_ipv6 = 1
# net.ipv6.conf.default.disable_ipv6 = 1
# net.ipv4.ip_forward = 1
# net.ipv4.tcp_syncookies = 1
# net.ipv4.tcp_tw_reuse = 1
# net.ipv4.tcp_tw_recycle = 1
# net.ipv4.tcp_fin_timeout = 30
# fs.file-max = 2048000
# fs.nr_open = 2048000
# fs.file-max = 1024000
# fs.aio-max-nr = 1048576

# /etc/security/limits.conf
# * soft    nofile  1024000
# * hard    nofile  1024000
# * soft    nproc   unlimited
# * hard    nproc   unlimited
# * soft    core    unlimited
# * hard    core    unlimited
# * soft    memlock unlimited
# * hard    memlock unlimited

