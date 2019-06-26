#!/bin/bash
for i in 10.81.180.{130..253}
do 
 {
  ping -c 2 -w 2 $i &>/dev/null
 if [ $? -eq 0 ]
   then
   echo $i is ok >> /home/shell/ip.txt
   else 
   echo $i is down >>/home/shell/ip.txt
 fi
 }&
done
