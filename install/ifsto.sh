#!/bin/bash

cd /usr/local/src

yum clean all 
yum makecache
yum -y install epel-release 
yum -y update
yum -y install wget jwhois bind-utils tmux mtr traceroute tcpdump tshark rpcbind nfs

systemctl enable rpcbind
systemctl enable nfs

wget -qO- https://raw.githubusercontent.com/ghosts1995/ops/master/install/igit.sh | bash && source /etc/bashrc && git --version

yum install -y http://files.freeswitch.org/freeswitch-release-1-6.noarch.rpm epel-release
 
yum install -y alsa-lib-devel autoconf automake bison broadvoice-devel bzip2 curl-devel libdb4-devel e2fsprogs-devel erlang flite-devel g722_1-devel gcc-c++ gdbm-devel gnutls-devel ilbc2-devel ldns-devel libcodec2-devel libcurl-devel libedit-devel libidn-devel libjpeg-devel libmemcached-devel libogg-devel libsilk-devel libsndfile-devel libtheora-devel libtiff-devel libtool libuuid-devel libvorbis-devel libxml2-devel lua-devel lzo-devel mongo-c-driver-devel ncurses-devel net-snmp-devel openssl-devel opus-devel pcre-devel perl perl-ExtUtils-Embed pkgconfig portaudio-devel postgresql-devel python-devel python-devel soundtouch-devel speex-devel sqlite-devel unbound-devel unixODBC-devel wget which yasm zlib-devel libshout-devel libmpg123-devel lame-devel

yum install -y gcc-c++ alsa-lib-devel autoconf automake bison bzip2 curl-devel e2fsprogs-devel flite-devel gdbm-devel gnutls-devel ldns-devel libcurl-devel libedit-devel libidn-devel libjpeg-devel libmemcached-devel libogg-devel libsndfile-devel libtiff-devel libtheora-devel libtool libvorbis-devel libxml2-devel lua-devel lzo-devel mongo-c-driver-devel ncurses-devel net-snmp-devel openssl-devel opus-devel pcre-devel perl perl-ExtUtils-Embed pkgconfig portaudio-devel postgresql-devel python-devel soundtouch-devel speex-devel sqlite-devel unbound-devel unixODBC-devel libuuid-devel which yasm zlib-devel


git clone -b aivoip https://github.com/ghosts1995/freeswitch.git freeswitch

chmod -R 777 /usr/local/src/freeswitch

cd /usr/local/src/freeswitch

./bootstrap.sh 

./configure

make 
make install
make cd-sounds-install
make cd-moh-install
ln -sf /usr/local/freeswitch/bin/freeswitch /usr/bin/ 
ln -sf /usr/local/freeswitch/bin/fs_cli /usr/bin/

echo "load server"

touch /usr/lib/systemd/system/freeswitch.service

tee /usr/lib/systemd/system/freeswitch.service <<-'EOF'

[Unit]
Description=FreeSWITCH
After=syslog.target network.target
After=mysqld.service

[Service]
User=root
EnvironmentFile=-/etc/sysconfig/freeswitch
WorkingDirectory=/usr/local/freeswitch
ExecStart=/usr/local/freeswitch/bin/freeswitch -nc -nf $FREESWITCH_PARAMS 
ExecReload=/usr/bin/kill -HUP $MAINPID
Restart=always

[Install]
WantedBy=multi-user.target graphical.target

EOF

echo "load system service"

systemctl --system daemon-reload


cd /usr/local/src/freeswitch


#install xml curl
sed -i 's/#applications\/mod_curl/applications\/mod_curl/g' /usr/local/src/freeswitch/modules.conf
sed -i 's/#xml_int\/mod_xml_curl/xml_int\/mod_xml_curl/g' /usr/local/src/freeswitch/modules.conf

./configure

make mod_xml_curl 
make mod_xml_curl-install

#install cdr

sed -i 's/#event_handlers\/mod_format_cdr/event_handlers\/mod_format_cdr/g' /usr/local/src/freeswitch/modules.conf
./configure
make mod_format_cdr-install


#install xml g729

cd /usr/local/src

git clone https://github.com/ghosts1995/mod_g729.git

cd mod_g729

make && make install

echo "install done"

# cd /usr/local
# useradd --system --home-dir /usr/local/freeswitch -G daemon freeswitch
# passwd -l freeswitch
# chown -R freeswitch:daemon /usr/local/freeswitch/ 
# chmod -R 770 /usr/local/freeswitch/
# chmod -R 750 /usr/local/freeswitch/bin/*
# mkdir /var/run/freeswitch
# chown -R freeswitch:daemon  /var/run/freeswitch
# ln -s /usr/local/freeswitch/bin/freeswitch /usr/bin/

systemctl enable freeswitch.service

systemctl start freeswitch.service

systemctl status freeswitch.service

serverId=$(sed -n 1p /var/log/voip.log)
serverAddr=$(sed -n 1p /var/log/voipAddr.log)
hostIp=$(sed -n 1p /var/log/voipIp.log)

echo $serverId
echo $serverAddr
echo $hostIp

FSCONFDIR="/usr/local/freeswitch/conf"

rm -rf $FSCONFDIR/vars.xml
curl -o $FSCONFDIR/vars.xml "$serverAddr/init/$serverId/vars"

rm -rf $FSCONFDIR/autoload_configs/modules.conf.xml
curl -o $FSCONFDIR/autoload_configs/modules.conf.xml "$serverAddr/init/$serverId/modules"

rm -rf $FSCONFDIR/autoload_configs/format_cdr.conf.xml
curl -o $FSCONFDIR/autoload_configs/format_cdr.conf.xml "$serverAddr/init/$serverId/cdr"

rm -rf $FSCONFDIR/autoload_configs/xml_curl.conf.xml
curl -o $FSCONFDIR/autoload_configs/xml_curl.conf.xml "$serverAddr/init/$serverId/curl"

rm -rf $FSCONFDIR/autoload_configs/event_socket.conf.xml
curl -o $FSCONFDIR/autoload_configs/event_socket.conf.xml "$serverAddr/init/$serverId/es"

rm -rf $FSCONFDIR/autoload_configs/acl.conf.xml
curl -o $FSCONFDIR/autoload_configs/acl.conf.xml "$serverAddr/init/$serverId/acl"

rm -rf $FSCONFDIR/directory/default.xml
curl -o $FSCONFDIR/directory/default.xml "$serverAddr/init/$serverId/directoryDefault"

rm -rf $FSCONFDIR/sip_profiles/external.xml
curl -o $FSCONFDIR/sip_profiles/external.xml "$serverAddr/init/$serverId/sipExternal"

rm -rf $FSCONFDIR/sip_profiles/internal.xml
curl -o $FSCONFDIR/sip_profiles/internal.xml "$serverAddr/init/$serverId/sipInternal"

echo "mkdir recordings"

mkdir -p /usr/local/freeswitch/recordings/$serverId

echo "/usr/local/freeswitch/recordings/$serverId $hostIp/32(ro,sync,no_root_squash,no_all_squash)" >> /etc/exports

exportfs -r
systemctl restart nfs
showmount -e localhost

curl -s "$serverAddr/init/$serverId/install"


systemctl restart freeswitch.service

echo "install done"


