#!/bin/bash

apps=("tomcat1" "tomcat2" "tomcat3")



function print_tip1
{
	echo "1) ${apps[0]}"
	echo "2) ${apps[1]}"
	echo "3) ${apps[2]}"
	echo "all) 全部应用"
	echo "q) 退出"
	echo "**********************************************************************"
}

function print_tip2
{
	echo "******************************************************************"
	echo "1) 应用状态"
	echo "2) 停止应用"
	echo "3) 重启应用"
	echo "4) 返回"
	echo "******************************************************************"
}

function check_app
{
	for aname in $app_name;do

		pid=`ps -ef |grep $aname |grep -v "grep" |awk '{print $2}'`
		if [ $pid ]; then
			status=`netstat -lntup|grep -v "grep"|grep $pid`
			echo "…………………………………………………………………………………………………………………………"
			echo "$aname  is  running  and pid=$pid"
			echo "使用的端口如下所示："
			echo "$status"
			echo "…………………………………………………………………………………………………………………………"
		else
			echo "…………………………………………………………………………………………………………………………"
			echo "$aname is not running"
			echo "…………………………………………………………………………………………………………………………"
		fi
	done
}

function stop_app
{
	for aname in $app_name;do
		sh /opt/$aname/apache-tomcat-8.5.42/bin/shutdown.sh
	done
}

function start_app
{
	for aname in $app_name;do
		sh /opt/$aname/apache-tomcat-8.5.42/bin/startup.sh
	done
}	


#function print_title
#{
#	echo "**************请选择***************"
#	print_tip1
#	read -p "输入: " app_choice
#	if [ $app_choice -eq 1 ];then
#		echo "选择的应用是：$app1"
#		app_name=$app1
#		print_title2
#	elif [ $app_choice -eq 2 ];then
#		echo "选择的应用是：$app2"
#		app_name=$app2
#		print_title2
#	elif [ $app_choice -eq 3];then
#		echo "选择的应用是：$app3"
#		app_name=$app2
#		print_title2
#	elif [ $app_choice -eq q ];then
#	exit
#	else 
#		echo "请输入1|2|3|4|q"
#	fi
#}

function print_title
{
	while true
	do
		echo "******************************请选择**********************************"
		print_tip1
		read -p "输入: " app_choice
		case $app_choice in
		1)
		echo ""
		echo "选择的应用是：$app1"
		app_name=${apps[0]}
		print_title2
		;;
		2)
		echo ""
		echo "选择的应用是：$app2"
		app_name=${apps[1]}
		print_title2
		;;
		3)
		echo ""
		echo "选择的应用是：$app3"
		app_name=${apps[2]}
		print_title2
		;;
		all)
		echo ""
		echo "选择的应用是: 全部应用！！"
		app_name=${apps[@]}
		print_title2
		;;
		q)
		exit
		;;
		*)
		echo "           "
		echo "输入1|2|3|4"
		esac
	done
}

function print_title2
{
	while true
	do
		print_tip2
		read -p "输入1|2|3|4 : " act_choice
		case $act_choice in
			1) check_app
			;;
			2) stop_app
			;;
			3) start_app
			;;
			4) print_title
			   exit
			;;
			*) echo "请输入1|2|3|4"
		esac
	done
}

print_title






