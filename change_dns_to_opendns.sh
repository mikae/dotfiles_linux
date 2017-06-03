#!/usr/bin/env bash
echo_green 'Creation of new /etc/resolv.conf'
sudo chattr -V -i /etc/resolv.conf
sudo rm -v /etc/resolv.conf
sudo touch /etc/resolv.conf
sudo su -c 'cat > /etc/resolv.conf << EOF
nameserver 208.67.222.222
nameserver 208.67.220.220
EOF'
sudo chattr -V +i /etc/resolv.conf
