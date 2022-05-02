#!/bin/bash
#Conky from c41m
# install conky on debian based os with requirements
sudo apt install conky-all git fonts-font-awesome grep libx11-dev gawk lm-sensors smartmontools -y
cd /tmp/ && rm -rf conky/
git clone https://github.com/prasanthc41m/conky
sudo cp -rf conky /etc/
# make executable
sudo chmod +x /etc/conky/*
sudo pkill conky
conky > /dev/null 2>&1
line="@reboot conky"
(crontab -u $(whoami) -l; echo "$line" ) | crontab -u $(whoami) -
echo "Conky is running..."
