#!/bin/bash

nginx_service="[Unit]
Description=nginx service
After=network.target

[Service]
Type=forking
ExecStart=/usr/local/nginx/sbin/nginx
ExecReload=/usr/local/nginx/sbin/nginx -s reload
ExecStop=/usr/local/nginx/sbin/nginx -s quit
PrivateTmp=true

[Install]
WantedBy=multi-user.target
"


wget http://nginx.org/download/nginx-1.16.0.tar.gz
yum install -y g++ gcc openssl openssl-devel pcre pcre-devel zlib-devel
tar zxvf nginx-1.16.0.tar.gz
cd nginx-1.16.0

./configure --with-http_ssl_module
make
make install 
echo "${nginx_service}">/lib/systemd/system/nginx.service
echo "Nginx install ok!(path:/usr/local/nginx)"
echo "Use systemctl start nginx.service"





