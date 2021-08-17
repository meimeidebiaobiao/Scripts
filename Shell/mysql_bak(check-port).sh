#!/bin/bash

DATE=`date +"%Y%m%d"`

`nc -v -z -w5 [mysql-ip] 3306`
result=$?

echo $result

if [ "$result" -eq 0 ];then
        echo $DATE 'mysql_port is open'
        mysqldump -h 127.0.0.1 -P 3306 -uroot -pxxx\<\>\? --databases ‘database-name’>/opt/mysql_bak/mysql_$DATE.bak $$\
        find /opt/mysql_bak -mtime +30 -name '*mysql_*.bak' -exec rm -f {} \; $$\
        echo $DATE 'Mysql Backup completed' >>./back.log
        else
        echo $DATE 'mysql_port is close'>>./back.log
fi
