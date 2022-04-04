#!/bin/bash
#Conky from c41m
apt install conky -y
cd /tmp/ && rm -rf conky
git clone https://github.com/prasanthc41m/conky
cp conky/* /etc/conky/conky/
conky > /dev/null 2>&1
exit
line="@reboot conky"
(crontab -u $(whoami) -l; echo "$line" ) | crontab -u $(whoami) -
