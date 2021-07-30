cat ip.txt | while read line
do
	IP=$line
	sudo sudo nping -c 2 --icmp $line > pingscan.txt
  #sudo nmap -A -p $PORTS $IP > $line/nmap/aggressive.txt
	#enum4linux $line > $line/enum4linux.txt
done
