#!/bin/bash

cat ip_list.txt | while read line
do
	mkdir $line/nmap/
	PORTS=$(cat ports_udp.txt)
	sudo nmap -sU -sV -p $PORTS $line > $line/nmap/udp2.txt
done
