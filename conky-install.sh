#!/bin/bash
#Conky from c41m
# install conky on debian based os with requirements
sudo apt install conky-all git fonts-font-awesome grep libx11-dev gawk lm-sensors smartmontools libcairo2-dev automake pkg-config libtool  -y
cd /tmp/ && rm -rf conky/
git clone https://github.com/prasanthc41m/conky
sudo cp -rf conky /etc/
# color
R='\033[0;31m'
G='\033[0;32m'
Y='\033[0;33m'
NOCOL='\033[0m' 
# network configuration
eth=$(basename /sys/class/net/e*)
wlan=$(basename /sys/class/net/w*)
echo -e Your Ethernet is "${Y}""$eth""${NOCOL}" and WiFi is "${Y}""$wlan""${NOCOL}"
result1="s/eth/$eth/g"
result2="s/wlan/$wlan/g"
#echo $result1 ; echo $result2
grep -rl 'eth' /tmp/conky.conf | xargs sed -i "$result1" & grep -rl 'wlan' /tmp/conky.conf | xargs sed -i "$result2"
# make executable
sudo chmod +x /etc/conky/*
sudo pkill conky
conky > /dev/null 2>&1
line="@reboot conky"
(crontab -u $(whoami) -l; echo "$line" ) | crontab -u $(whoami) -
echo "${Y}""Conky is running...""${NOCOL}"
