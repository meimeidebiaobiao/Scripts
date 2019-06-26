#!/bin/bash
#

DATE=`date +"%Y%m%d"`

mysql -u root -pXXX --all-databases > /home/bak/mysql_$DATE.bak
