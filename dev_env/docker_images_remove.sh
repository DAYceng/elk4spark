#!/bin/bash
cur_dir=$(cd $(dirname $0)  && pwd)
parent_dir=$(cd $(dirname $0) && cd .. && pwd)

bash docker_containers_remove.sh

echo "删除所有镜像 ......"
docker rmi -f $(docker images -qa)

docker images