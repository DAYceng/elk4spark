#!/bin/bash
cur_dir=$(cd $(dirname $0)  && pwd)
parent_dir=$(cd $(dirname $0) && cd .. && pwd)

# 安装并后台运行所有的容器
cd ${parent_dir}/hadoop
docker-compose down
docker-compose up -d

# 查看hadoop容器网络状态
docker network inspect hadoop_default

# 查看容器状态
docker ps -a