#!/bin/sh

# echo "This script is restricted to CentOS only."

echo "This script is restricted to CentOS only.
-----------------------------------------
Choice New installation,Please enter:new
-----------------------------------------
Choice Reset IP,Please enter:ip
-----------------------------------------
Choice installation bbr,Please enter:bbr
-----------------------------------------
Choice add port ip,Please enter:addip"

################################
#Get the external network IP
################################
# LOCALNETWORKIP=$(curl http://65.49.226.175:9191/reverse/clinet/get/ip?type=ip -s)

#get the localhost ip
LOCALNETWORKIP=$(/sbin/ifconfig -a | grep inet | grep -v 127.0.0.1 | grep -v inet6 | awk '{print $2}' | tr -d "addrs")

# echo "#################"
# echo $LOCALNETWORKIP

############################Reset IP###################################
Reset_IP(){
echo "################################"
echo "Start reset ip"
echo "################################"
echo "Please set up according to the prompt."
echo "################################"
echo "Forwarding target IP"
echo "################################"
read RESETIP
echo "################################"
echo "Forwarding target port"
echo "################################"
read PORT
echo "############show ip:port###############"
echo $RESETIP':'$PORT

iptables -F && iptables -F -t nat && iptables -X

iptables -t nat -A PREROUTING -p tcp --dport $PORT -j DNAT --to-destination $RESETIP:$PORT
iptables -t nat -A POSTROUTING -p tcp -d $RESETIP --dport $PORT -j SNAT --to-source $LOCALNETWORKIP

iptables -t nat -A PREROUTING -p udp --dport $PORT -j DNAT --to-destination $RESETIP:$PORT
iptables -t nat -A POSTROUTING -p udp -d $RESETIP --dport $PORT -j SNAT --to-source $LOCALNETWORKIP

service iptables save
service iptables restart

}

############################add IP###################################

Add_IP(){
echo "################################"
echo "Start add ip"
echo "################################"
echo "Please set up according to the prompt."
echo "################################"
echo "Forwarding target IP"
echo "################################"
read RESETIP
echo "################################"
echo "Forwarding target port"
echo "################################"
read PORT
echo "################################"
echo "Localhost Forwarding target port"
echo "################################"
read LOCALPORT
echo "############show ip:port###############"
echo $LOCALNETWORKIP':'$LOCALPORT '- SERVER -' $RESETIP':'$PORT

iptables -t nat -A PREROUTING -p tcp --dport $LOCALPORT -j DNAT --to-destination $RESETIP:$PORT
iptables -t nat -A POSTROUTING -p tcp -d $RESETIP --dport $PORT -j SNAT --to-source $LOCALNETWORKIP

iptables -t nat -A PREROUTING -p udp --dport $LOCALPORT -j DNAT --to-destination $RESETIP:$PORT
iptables -t nat -A POSTROUTING -p udp -d $RESETIP --dport $PORT -j SNAT --to-source $LOCALNETWORKIP

service iptables save
service iptables restart

}

############################New_Installation###################################

New_Installation(){
echo "################################"
echo "Start new installation"
echo "################################"
echo "Please set up according to the prompt."
echo "################################"
echo "Forwarding target IP"
echo "################################"
read INRESETIP
echo "################################"
echo "Forwarding target port"
echo "################################"
read INPORT
echo "############show ip:port###############"
echo $INRESETIP':'$INPORT


systemctl stop firewalld.service
systemctl disable firewalld.service
systemctl mask firewalld
ulimit -n 100000
yum install -y iptables iptables-services 

echo 'net.ipv4.ip_forward=1' >> /etc/sysctl.conf
sysctl -p

iptables -F && iptables -F -t nat && iptables -X

iptables -t nat -A PREROUTING -p tcp --dport $INPORT -j DNAT --to-destination $INRESETIP:$INPORT
iptables -t nat -A POSTROUTING -p tcp -d $INRESETIP --dport $INPORT -j SNAT --to-source $LOCALNETWORKIP

iptables -t nat -A PREROUTING -p udp --dport $INPORT -j DNAT --to-destination $INRESETIP:$INPORT
iptables -t nat -A POSTROUTING -p udp -d $INRESETIP --dport $INPORT -j SNAT --to-source $LOCALNETWORKIP

service iptables save && service iptables restart
systemctl enable iptables.service 
systemctl disable iptables.service

}

#####bbr 
Insetll_Bbr(){
echo "################################"
echo "insetll bbr"
echo "################################"
echo "wget"
wget --no-check-certificate https://github.com/teddysun/across/raw/master/bbr.sh && chmod +x bbr.sh && ./bbr.sh
}

read CHOICE

case $CHOICE in

	"ip") Reset_IP
;;
	"bbr") Insetll_Bbr
;;
	"new") New_Installation
;;
    "addip") Add_IP
;;
	*) echo "Can't find the related server name"
	exit
;;
esac
