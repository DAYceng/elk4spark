#!/bin/bash
cur_dir=$(cd $(dirname $0)  && pwd)
parent_dir=$(cd $(dirname $0) && cd .. && pwd)

echo "删除所有容器 ......"
docker stop $(docker ps -q)
docker rm $(docker ps -aq)

docker ps -a