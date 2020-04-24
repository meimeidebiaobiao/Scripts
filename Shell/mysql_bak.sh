#!/bin/bash
#

DATE=`date +"%Y%m%d"`

mysqldump -uroot -pXXX --all-databases -hhost > /home/bak/mysql_$DATE.bak
