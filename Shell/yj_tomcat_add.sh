#!/bin/bash


read -p "输入新添加的应用名称: " app_name
echo "正在运行的tomcat端口如下，请勿重复！"
netstat -lntup|grep java
read -p "输入应用使用端口（默认8080）:" app_port1
read -p "输入tomcat的关闭端口（默认8005）:" app_port2
read -p "输入tomcatde ajp端口(默认8009):" app_port3
read -p "即将再/opt下添加一个文件夹$app_name并添加tomcat，应用端口为$app_port1,关闭监听端口为$app_port2,ajp端口为$app_port3,yes or no?" ans

case $ans in
	yes)
	mkdir /opt/$app_name
	tar zxvf apache-tomcat-8.5.42.tar.gz -C /opt/$app_name
	sed -i "s/8080/$app_port1/g" /opt/$app_name/apache-tomcat-8.5.42/conf/server.xml
	sed -i "s/8009/$app_port2/g" /opt/$app_name/apache-tomcat-8.5.42/conf/server.xml
	sed -i "s/8005/$app_port3/g" /opt/$app_name/apache-tomcat-8.5.42/conf/server.xml
	#rm -rf /opt/$app_name/apache-tomcat-8.5.42/webapps/*
	mv ROOT.war /opt/$app_name/apache-tomcat-8.5.42/webapps/
	;;
	no)
	exit
	;;
	*)
	echo "请输入yes/no"
esac
