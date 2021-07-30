#!/bin/bash

cat tmp.txt | while read line 
do
	mkdir $line
	mkdir $line/nmap
	nmap -sn -Pn $line > $line/nmap/up.txt
	sudo nmap -sT -p- $line > $line/nmap/tcp.txt
	sudo nmap -sS -p- $line > $line/nmap/syn.txt
	(grep "/tcp" $line/nmap/syn.txt|awk -F "/" '{print $1}') > $line/nmap/ports.txt
	sed -i -z 's/\n/,/g;s/,$/\n/' $line/nmap/ports.txt
	PORTS=$(cat $line/nmap/ports.txt) 
	sudo nmap -sV -O -p $PORTS $line > $line/nmap/version.txt
	enum4linux $line > $line/enum4linux.txt
done






















