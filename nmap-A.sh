#!/bin/bash

cat wifi-A.txt | while read line
do
	PORTS=$(cat $line/nmap/ports.txt)
	sudo nmap -A -p $PORTS $line > $line/nmap/aggressive2.txt
done
