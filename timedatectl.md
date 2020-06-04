yum -y install ntp
systemctl enable ntpd 
systemctl start ntpd 
timedatectl set-timezone Asia/Singapore
timedatectl set-ntp yes
ntpq -p
