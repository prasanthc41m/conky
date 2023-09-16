#!/bin/bash
#Conky from c41m

if [  -n "$(uname -a | grep fedora)" ]; then
    sudo dnf install conky git fontawesome5-fonts-all fontawesome-fonts grep libX11-devel.x86_64 gawk lm_sensors.x86_64 smartmontools automake pkg-config libtool hwinfo.x86_64 glx-utils.x86_64  -y    
else
    sudo apt install conky-all git fonts-font-awesome grep libx11-dev gawk lm-sensors smartmontools libcairo2-dev automake pkg-config libtool glx-utils glx-utils -y
fi  
sudo dnf install conky git fontawesome5-fonts-all fontawesome-fonts grep libX11-devel.x86_64 gawk lm_sensors.x86_64 smartmontools automake pkg-config libtool hwinfo.x86_64 glx-utils.x86_64  -y
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
#echo -e debug: ${Y}$result1 $result2${NOCOL}
grep -rl 'eth' /etc/conky/conky.conf | xargs sed -i "$result1"  
grep -rl 'wlan' /etc/conky/conky.conf | xargs sed -i "$result2"
# make executable
sudo chmod +x /etc/conky/*
sudo pkill conky
mkdir -p ~/.config/autostart
cp /usr/share/applicaions/conky.desktop ~/.config/autostart
echo -e "${G}""Conky is running...""${NOCOL}"
rm -rf /tmp/conky*
