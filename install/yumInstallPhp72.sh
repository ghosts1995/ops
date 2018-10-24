#!/bin/bash

yum -y install epel-release
yum -y install wget jwhois bind-utils tmux screen

rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-7.rpm
yum --enablerepo=remi-php72 -y install php-fpm php-common
yum --enablerepo=remi-php72 -y install php-opcache php-pecl-apcu php-cli php-pear php-pdo php-mysqlnd php-pgsql php-pecl-mongodb php-pecl-redis php-pecl-memcache php-pecl-memcached php-pecl-swoole4 php-pecl-seaslog php-gd php-mbstring php-mcrypt php-xml php-devel screen
