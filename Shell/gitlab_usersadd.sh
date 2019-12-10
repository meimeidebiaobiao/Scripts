#!/bin/bash

#需要在同级目录下创建userinof.txt,里面添加的用户信息
# name username userpass mail

#需要先在gitlab上创建access token替换下方的private_token

userinfo="userinfo.txt"
while read line 
do
name=`echo $line|awk '{print $1}'`
username=`echo $line|awk '{print $2}'`
userpass=`echo $line|awk '{print $3}'`
mail=`echo $line|awk '{print $4}'`
curl -d "can_create_group=false&password=$userpass&email=$mail&username=$username&name=$name&private_token=qxxgPTxxxe1qH8J1" "http://gitlab.xxx.com/api/v4/users"
done<$userinfo