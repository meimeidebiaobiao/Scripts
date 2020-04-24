#!/bin/bash
#

DATE=`date +"%Y%m%d"`

mysql -uroot -pXXX --all-databases -hhost > /home/bak/mysql_$DATE.bak
