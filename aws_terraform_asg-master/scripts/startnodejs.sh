#!/bin/bash
set -x
mkdir -p /var/www/gogoui
git clone  https://github.com/opsworkshop/node-hello.git
cp -ar node-hello/* /var/www/gogoui/
mkdir -p /etc/supervisor/conf.d
cp -vp /tmp/scripts/gogoui.conf /etc/supervisor/conf.d/
cp -vp /tmp/scripts/supervisord.conf /etc/supervisord.conf
cp -vp /tmp/scripts/supervisord /etc/init.d/supervisord
chmod 744 /etc/init.d/supervisord
/etc/init.d/supervisord start
chkconfig nginx on
ln -s /etc/init.d/supervisord /etc/rc3.d/S200supervisord
