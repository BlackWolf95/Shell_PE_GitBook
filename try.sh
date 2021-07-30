#!/bin/bash

cat hosts.txt | while read line
do
  var="ssh -oKexAlgorithms=+diffie-hellman-group1-sha1 root@";
  var=$var$line
  echo $var
done
