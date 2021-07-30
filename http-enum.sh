#!/bin/bash

# We detect all IPs that contains http(s) services
#(((grep "open  http" ./10* -r)||(grep "open  https" ./10* -r))|awk -F "/" '{print $2}') > ip-http.txt

# We sort it ascending (respecting ip format) and removing duplicates
#sort -t . -k 3,3n -k 4,4n ip-http.txt|uniq > ip-http-sorted.txt
#rm ip-http.txt
#echo "" >> ip-http-sorted.txt

# All previous is here as reminder of findings, but it would cause many redundant scans.

cat wifi-A.txt | while read line
do
	# We store http ports
	(grep "open  http" $line/nmap/tcp.txt)|(grep -v "https")|(grep -v "ssl/http")|awk -F "/" '{print $1}' > $line/nmap/http-ports.txt
	# We store https ports
	(grep 'open  https\|open  ssl/http' $line/nmap/tcp.txt)|awk -F "/" '{print $1}' > $line/nmap/https-ports.txt
	echo "" >> http-ports.txt
	echo "" >> https-ports.txt
	# We read http ports and launch nikto then dirb on them
	cat $line/nmap/http-ports.txt | while read http_port
	do
		mkdir $line/nikto
		nikto -host http://$line:$http_port -output $line/nikto/$http_port.txt
		mkdir $line/dirb
		dirb http://$line:$http_port/ /usr/share/dirb/wordlists/big.txt -X .txt,.php,.html,.bak,.bu,.zip,.7z,.tar,.gz,.conf,.ini,.cnf -o $line/dirb/$http_port.txt
	done
	# We read httpS ports and launch nikto then dirb on them
	cat $line/nmap/https-ports.txt | while read https_port
	do
		mkdir $line/nikto
		nikto -host https://$line:$https_port -output $line/nikto/$https_port.txt
		mkdir $line/dirb
		dirb https://$line:$https_port/ /usr/share/dirb/wordlists/big.txt -X .txt,.php,.html,.bak,.bu,.zip,.7z,.tar,.gz,.conf,.ini,.cnf -o $line/dirb/$https_port.txt
	done
done
