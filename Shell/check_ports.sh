#!/bin/bash
host_array=(192.168.10.39 192.168.10.41)
#监测端口
check_port(){
for PORT in $PORT; do
    if echo &>/dev/null > /dev/tcp/$ip/$PORT; then
        echo "[$ip]的$PORT端口 open"
    else
        echo "[$ip]的$PORT端口 close"
        restart_projecrt
    fi
done
}
#监测端口，重启服务
restart_projecrt(){
    if [ $PORT -eq 3306 ];then
        echo "请重启数据库"
    elif [ $PORT -eq 8080 ];then
        echo "请重启后端接口api"
    fi
}
for ip in ${host_array[@]}
    do
        PORT="22 80 8080 3306 41853 111"
        echo "=======【$ip】========"
        check_port
    done