#!/bin/bash

OUTPUT_FILE="/home/alght/Desktop/HW_L4_01_linux/firewall_rules.txt"


LOCAL_IP="192.168.1.100"   

echo "========================================" > $OUTPUT_FILE
echo "Firewall Rules - $(date)" >> $OUTPUT_FILE
echo "========================================" >> $OUTPUT_FILE


echo "Flushing existing rules..."
sudo iptables -F
sudo iptables -X
sudo iptables -t nat -F
sudo iptables -t mangle -F


sudo iptables -P INPUT DROP
sudo iptables -P FORWARD DROP
sudo iptables -P OUTPUT ACCEPT


sudo iptables -A INPUT -i lo -j ACCEPT


sudo iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT


sudo iptables -A INPUT -p tcp --dport 22 -s $LOCAL_IP -j ACCEPT


sudo iptables -A INPUT -p tcp --dport 80 -j ACCEPT


sudo iptables -A INPUT -p tcp --dport 443 -j ACCEPT




echo "" >> $OUTPUT_FILE
sudo iptables -L -v -n >> $OUTPUT_FILE

echo "" >> $OUTPUT_FILE
echo "========================================" >> $OUTPUT_FILE
echo "Firewall setup completed. Rules saved in $OUTPUT_FILE" >> $OUTPUT_FILE


cat $OUTPUT_FILE
