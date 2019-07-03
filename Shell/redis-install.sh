#!/bin/bash

redis_service="[Unit]
Description=redis.server
After=network.target

[Service]
Type=forking
PIDFILE=/var/run/redis_6379.pid
ExecStart=/usr/local/redis/bin/redis-server /usr/local/redis/etc/redis.conf
ExecRepload=/bin/kill -s HUP $MAINPID
ExecStop=/bin/kill -s QUIT $MAINPID
PrivateTmp=true
[Install]
WantedBy=multi-user.target
"



wget http://download.redis.io/releases/redis-5.0.4.tar.gz
yum install -y gcc g++
tar zxvf redis-5.0.4.tar.gz
mkdir -p /usr/local/redis/etc
cd redis-5.0.4
cp redis.conf /usr/local/redis/etc

#修改配置外网可访问
sed -i "s/protected-mode no/protected-mode yes/g" /usr/local/redis/etc/redis.conf
sed -i "s/bind 127.0.0.1/#bind 127.0.0.1/g" /usr/local/redis/etc/redis.conf

make install PREFIX=/usr/local/redis
echo "${redis_service}">/lib/systemd/system/redis.service
echo "Redis install ok!(path:/usr/local/redis)"
echo "Use systemctl start redis"





