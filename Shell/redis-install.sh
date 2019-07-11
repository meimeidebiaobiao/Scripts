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
mkdir -p /usr/local/redis/{etc,data}
cd redis-5.0.4
cp redis.conf /usr/local/redis/etc

#修改配置外网可访问
sed -i "s/protected-mode no/protected-mode yes/g" /usr/local/redis/etc/redis.conf
sed -i "s/bind 127.0.0.1/#bind 127.0.0.1/g" /usr/local/redis/etc/redis.conf
#配置开启持久性存储AOF
sed -i "s/appendonly no/appendonly yes/g" /usr/local/redis/etc/redis.conf
#修改AOF及RBD存放路径
sed -i "s/dir .\//dir \/usr\/local\/redis\/data/g" /usr/local/redis/etc/redis.conf
#修改log存放路径
sed -i "s/logfile \"\"/logfile \/usr\/local\/redis\/data\/redis.log/g" /usr/local/redis/etc/redis.conf

make
make install PREFIX=/usr/local/redis

#把redis服务添加至systemctl管理
echo "${redis_service}">/lib/systemd/system/redis.service
echo "export PATH="\$PATH:/usr/local/redis/bin"">>/etc/profile
echo "Redis install ok!(path:/usr/local/redis)"
echo "Use systemctl start redis"





