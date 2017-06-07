#!/bin/bash

sudo iptables -F
sudo iptables -X
sudo iptables -Z

sudo iptables -P INPUT DROP
sudo iptables -P FORWARD DROP
sudo iptables -P OUTPUT ACCEPT

sudo iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
sudo iptables -A INPUT -i lo -j ACCEPT
sudo iptables -A INPUT -p icmp --icmp-type 3 -j ACCEPT
sudo iptables -A INPUT -p icmp --icmp-type 11 -j ACCEPT
sudo iptables -A INPUT -p icmp --icmp-type 12 -j ACCEPT
sudo iptables -A INPUT -p tcp --syn --dport 113 -j REJECT --reject-with tcp-reset

sudo ip6tables -F
sudo ip6tables -X
sudo ip6tables -Z

sudo ip6tables -P INPUT DROP
sudo ip6tables -P FORWARD DROP
sudo ip6tables -P OUTPUT ACCEPT

sudo ip6tables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
sudo ip6tables -A INPUT -i lo -j ACCEPT
sudo ip6tables -A INPUT -m conntrack --ctstate INVALID -j DROP
sudo ip6tables -A INPUT -s fe80::/10 -p ipv6-icmp -j ACCEPT
sudo ip6tables -A INPUT -p udp -m conntrack --ctstate NEW -j REJECT --reject-with icmp6-port-unreachable
sudo ip6tables -A INPUT -p tcp -m tcp --tcp-flags FIN,SYN,RST,ACK SYN -m conntrack --ctstate NEW -j REJECT --reject-with tcp-reset

# Added iptables services
sudo systemctl enable iptables-store.service
sudo systemctl enable iptables-restore.service
sudo systemctl enable ip6tables-restore.service
sudo systemctl enable ip6tables-store.service
