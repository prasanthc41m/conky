#!/bin/bash
#Conky from c41m
apt install conky -y
cd /etc/conky
git clone https://github.com/prasanthc41m/conky
mv /etc/conky/conky/* .
rm -rf /etc/conky/conky
