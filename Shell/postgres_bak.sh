#!/bin/bash
#

DATE=`date +"%Y%m%d"`
#  -U 帐户名 数据库
pg_dump -U postgres postgres > /home/bak/wb_pg_$DATE.bak
# 导入 pg_dump -d 数据库名 -U 帐户名 -f pg.sql