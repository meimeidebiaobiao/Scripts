#!/bin/bash

log_directory="/data/logs"

# 遍历 /data 目录下的所有子目录
for directory in /data/app/*; do
    if [ -d "$directory" ]; then
        # 检查是否存在 upload.sh 文件
        upload_script="$directory/upload.sh"
        if [ -f "$upload_script" ]; then
            # 获取目录名称，作为容器名称的一部分
            container_name=$(basename "$directory")

            # 给 upload.sh 添加挂载存储的参数
            sed -i "s|docker run|docker run -v $log_directory/$container_name:/logs/|" "$upload_script"

            echo "Updated $upload_script"
        else
            echo "No upload.sh file found in $directory"
        fi
    fi
done