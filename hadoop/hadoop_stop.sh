#!/bin/bash
cur_dir=$(cd $(dirname $0)  && pwd)
parent_dir=$(cd $(dirname $0) && cd .. && pwd)

if [[ -n $(docker network list -q -f "name=^elk_spark_elastinet$") ]];then
	echo "elk_spark网络运行中，请先运行/elk_spark/dev_env/docker_compose_stop.sh将其停止"
    
else
	echo "elk_spark网络已停止，正在结束hadoop网络"
    # 停止运行有docker-compose启动的容器
    cd ${parent_dir}/hadoop
    docker-compose down
    # 查看容器状态
    docker ps -a
fi