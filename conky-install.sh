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
#echo -e debug: ${Y}$result1 $result2${NOCOL}
grep -rl 'eth' /etc/conky/conky.conf | xargs sed -i "$result1"  
grep -rl 'wlan' /etc/conky/conky.conf | xargs sed -i "$result2"
#GPU configuration
while true
do
      read -r -p "Do you have Nvidia GPU? [Y/n]"   input
      
      case $input in
            [yY][eE][sS]|[yY])
                  echo "Yes" 
                  break
                  ;;
            [nN][oO]|[nN])
                  echo "No" ; sudo sed -i '/^${color2}${exec nvidia-smi --query-gpu=gpu_name --format=csv,noheader,nounits}$color ${goto 210} ${exec nvidia-smi | grep % | cut -c 61-63} % ${goto 270} ${exec nvidia-smi | grep % | cut -c 37-40} MB ${goto 340}${exec nvidia-smi | grep % | cut -c 21-23} W       ${color3}${nvidia temp}°C$/s/^/#/' /etc/conky/conky.conf ; sudo sed -i '/^${color2}AMD Radeon     ${color3}${font :size= 9}${lua_parse igputemp}°C$/s/^/#/' /etc/conky/conky.conf ; echo -e "${Y}""Done""${NOCOL}"
                  break
                  ;;
            *)
                  echo "Invalid input..."
                  ;;
      esac      
done
# make executable
sudo chmod +x /etc/conky/*
sudo pkill conky
conky > /dev/null 2>&1
line="@reboot conky"
(crontab -u $(whoami) -l; echo "$line" ) | crontab -u $(whoami) -
echo -e "${G}""Conky is running...""${NOCOL}"
rm -rf /tmp/conky*
