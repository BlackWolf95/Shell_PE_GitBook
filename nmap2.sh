cat ip_list.txt | while read line
do
	PORTS=$(cat ports.txt)
	IP=$line
	#mkdir $line
	mkdir $line/nmap_version_det
	#sudo nmap -sn -Pn -p $PORTS $IP > $line/nmap/up.txt
	#sudo nmap -sT -Pn -p $PORTS $IP > $line/nmap/tcp.txt
	#sudo nmap -sS -Pn -p $PORTS $IP > $line/nmap/syn.txt
	sudo nmap -sV -Pn -O -p $PORTS $IP > $line/nmap_version_det/version.txt
	#sudo nmap -sU -Pn -p $PORTS $IP > $line/nmap/udp.txt
  #sudo nmap -A -p $PORTS $IP > $line/nmap/aggressive.txt
	#enum4linux $line > $line/enum4linux.txt
done
