#!/bin/bash

cat info.txt|while read num bucket area
do	
	DATE=`date +"%Y%m%d%H%M"`
	sed -i "6s/.*/taskName = \"$DATE-$num\"/g" /home/importoss/conf/task.toml &&
	sed -i "23s/.*/srcDomain = $area/g" /home/importoss/conf/task.toml &&
	sed -i "25s/.*/srcBucket = \"$bucket\"/g" /home/importoss/conf/task.toml &&
	sed -i "47s/.*/destBucket = \"$bucket\"/g" /home/importoss/conf/task.toml &&
	sh /home/importoss/console.sh submit &&
	sh /home/importoss/console.sh start &&
	echo $DATE-$bucket ,"存储桶同步任务已完成">> /home/importoss/cron.log
done