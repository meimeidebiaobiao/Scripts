#!/bin/bash

apps=("merchants" "order" "product" "report" "ticket")



function print_tip1
{
	echo "1) ${apps[0]}"
	echo "2) ${apps[1]}"
	echo "3) ${apps[2]}"
	echo "4) ${apps[3]}"
	echo "5) ${apps[4]}"
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
			echo ""
			echo "…………………………………………………………………………………………………………………………"
			echo "$aname  is  running  and pid=$pid"
			echo "使用的端口如下所示："
			echo "$status"
			echo "…………………………………………………………………………………………………………………………"
			echo ""
		else
			echo ""
			echo "…………………………………………………………………………………………………………………………"
			echo "$aname is not running"
			echo "…………………………………………………………………………………………………………………………"
			echo ""
		fi
	done
}

function stop_app
{
	for aname in $app_name;do
		pid=`ps -ef |grep $aname |grep -v "grep" |awk '{print $2}' `
		if [ $pid ]; then
			echo "$aname is running and pid=$pid"
			kill -9 $pid
			sleep 3
			if [[ $? -eq 0 ]];then
				echo "sucess to stop $aname"
			else
				echo "fail to stop $aname"
			fi
		else
			echo "$aname is not running!"
		fi
	done
}

function start_app
{
	for aname in $app_name;do
		pid=`ps -ef |grep $aname |grep -v "grep" |awk '{print $2}'`
		if [ $pid ]; then
			status=`netstat -lntup|grep -v "grep"|grep $pid`
			echo ""
			echo "…………………………………………………………………………………………………………………………"
			echo "程序已启动，如需重启请先停止！"
			echo "$aname  is  running  and pid=$pid"
			echo "使用的端口如下所示："
			echo "$status"
			echo "…………………………………………………………………………………………………………………………"
			echo ""
		else
			echo ""
			echo "…………………………………………………………………………………………………………………………"
			nohup java -jar /home/$aname/$aname-provider-1.0-SNAPSHOT.war >> /home/logs/$aname.log 2>&1 &
			echo "$aname 正在启动...请耐心等待，可使用check_app查看"
			echo "…………………………………………………………………………………………………………………………"
			echo ""
		fi
	done
}	

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
		echo "选择的应用是：${apps[0]}"
		app_name=${apps[0]}
		print_title2
		;;
		2)
		echo ""
		echo "选择的应用是：$${apps[1]}"
		app_name=${apps[1]}
		print_title2
		;;
		3)
		echo ""
		echo "选择的应用是：${apps[2]}"
		app_name=${apps[2]}
		print_title2
		;;
		4)
		echo ""
		echo "选择的应用是：${apps[3]}"
		app_name=${apps[3]}
		print_title2
		;;
		5)
		echo ""
		echo "选择的应用是：${apps[4]}"
		app_name=${apps[4]}
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
		echo "输入1|2|3|4|5|all"
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






