#!/bin/bash
#Conky from c41m
apt install conky -y
cd /tmp/ && rm -rf conky/
git clone https://github.com/prasanthc41m/conky
sudo mv -f conky /etc/
sudo pkill conky
exit
conky > /dev/null 2>&1
line="@reboot conky"
(crontab -u $(whoami) -l; echo "$line" ) | crontab -u $(whoami) -
echo 'Conky is running...'
