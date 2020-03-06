#!/bin/bash

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

