#!/bin/bash

ns_status=("test-up" "test-down" "dev-up" "dev-down")



function print_tip1
{
	echo "******************************请选择**********************************"
	echo "1) ${ns_status[0]} 测试环境NS启用，对应test_ns_start_name文件"
	echo "2) ${ns_status[1]} 测试环境NS关闭，对应test_ns_stop_name文件"
	echo "3) ${ns_status[2]} 开发环境NS启用，对应dev_ns_start_name文件"
	echo "4) ${ns_status[3]} 开发环境NS关闭，对应dev_ns_stop_name文件"
	echo "q) 退出"
	echo "**********************************************************************"
}

function stop_test_ns
{
	for i in `cat test_ns_stop_name`;
	do
		echo "关闭空间 $i"
		kubectl get deploy -n $i |grep -v NAME|grep -v redis|awk '{print $1}'|xargs -I {} kubectl scale deploy {} --replicas=0 -n $i
	done
}

function start_test_ns
{
	for i in `cat test_ns_start_name`;
	do
		echo "启用空间 $i"
		kubectl get deploy -n $i |grep -v NAME|grep -v redis|awk '{print $1}'|xargs -I {} kubectl scale deploy {} --replicas=1 -n $i
	done
}

function stop_dev_ns
{
	for i in `cat dev_ns_stop_name`;
	do
		echo "关闭空间 $i"
		kubectl get deploy -n $i |grep -v NAME|grep -v redis|awk '{print $1}'|xargs -I {} kubectl scale deploy {} --replicas=0 -n $i
	done
}

function start_dev_ns
{
	for i in `cat dev_ns_start_name`;
	do
		echo "启用空间 $i"
		kubectl get deploy -n $i |grep -v NAME|grep -v redis|awk '{print $1}'|xargs -I {} kubectl scale deploy {} --replicas=1 -n $i
	done
}

function print_title
{
	while true
	do
		print_tip1
		read -p "输入1|2|3|4|q : " act_choice
		case $act_choice in
			1) start_test_ns
			;;
			2) stop_test_ns
			;;
			3) start_dev_ns
			;;
			4) stop_dev_ns
			;;
			q)
		    exit
			;;
			*)
			echo "           "
			echo "输入1|2|3|4|q"
		esac

		
	done
}

print_title