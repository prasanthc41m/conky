#!/bin/bash
#Conky from c41m
apt install conky -y
cd /tmp/
git clone https://github.com/prasanthc41m/conky
cd /tmp/conky
mv /etc/conky/conky/* .
conky &&
line="@reboot conky"
(crontab -u $(whoami) -l; echo "$line" ) | crontab -u $(whoami) -
