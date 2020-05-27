#!/bin/bash
#

DATE=`date +"%Y%m%d"`

/opt/mongodb/bin/mongodump -o /home/bak/mangodb/wb_mgdb_$DATE
cd /home/bak/mangodb
tar zcf wb_mgdb_$DATE.tar.gz wb_mgdb_$DATE
bye
!
