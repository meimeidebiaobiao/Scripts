#!/bin/bash

java_tar=jdk-8u211-linux-x64.tar.gz
java_v=jdk1.8.0_211
tar -zxvf $java_tar -C /usr/local
cat >> /etc/profile <<EOF
export JAVA_HOME=/usr/local/$java_v
export PATH=\$PATH:\$JAVA_HOME/bin
EOF
source /etc/profile
echo Java-install ok
