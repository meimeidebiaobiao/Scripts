#!/bin/bash

#监控Nginx进程
#建议使用nohup ./nginx_monitor.sh >/dev/null 2>&1
DATE=`date +%Y%m%d-%H:%M:%S`

while true
do
	status=`ps -ef|grep nginx|grep -v grep|grep -v $$`
	
	if [ $? -eq 0 ];then
		echo "Nginx is runing"
	else
		echo "Nginx is down!Start Nginx.."
		echo "$DATE  Nginx is down!Start Nginx" >>nginx_monitor.log
		systemctl start nginx
	fi
	sleep 10
done
