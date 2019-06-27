#!/bin/bash

PROJECTNAME=demo

pid=`ps -ef |grep $PROJECTNAME |grep -v "grep" |awk '{print $2}'`

if [ $pid ]; then

​    echo "$PROJECTNAME  is  running  and pid=$pid"

else

   echo "Start success to start $PROJECTNAME ...."

   nohup java -jar demo.jar  >> catalina_$PROJECTNAME.out  2>&1 &

fi
