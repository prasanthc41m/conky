#!/bin/bash
#Conky from c41m
apt install conky -y
cd /tmp/
git clone https://github.com/prasanthc41m/conky
cd /tmp/conky
cp -f /etc/conky/conky/* .
conky &&
exit
line="@reboot conky"
(crontab -u $(whoami) -l; echo "$line" ) | crontab -u $(whoami) -
