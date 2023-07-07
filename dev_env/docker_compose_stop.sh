#!/bin/bash
cur_dir=$(cd $(dirname $0)  && pwd)
parent_dir=$(cd $(dirname $0) && cd .. && pwd)

# 停止运行有docker-compose启动的容器
cd ${parent_dir}
docker-compose down

# 查看容器状态
docker ps -a

cd ${parent_dir}/hadoop
bash hadoop_stop.sh



