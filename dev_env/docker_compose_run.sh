#!/bin/bash
cur_dir=$(cd $(dirname $0)  && pwd)
parent_dir=$(cd $(dirname $0) && cd .. && pwd)


# 更改文件夹权限防止es容器运行出错
chmod 777 ${parent_dir}/elasticsearch/esdata -R

# 安装并后台运行所有的容器
cd ${parent_dir}
docker-compose down
docker-compose up -d

# 确保es容器支持es_head 
docker exec elksj-elasticsearch /bin/bash -c 'echo http.cors.enabled: true >> /usr/share/elasticsearch/config/elasticsearch.yml'
docker exec elksj-elasticsearch /bin/bash -c 'echo http.cors.allow-origin: \"*\" >> /usr/share/elasticsearch/config/elasticsearch.yml'
# docker exec elksj-elasticsearch cat /usr/share/elasticsearch/config/elasticsearch.yml
docker restart elksj-elasticsearch

# 确保juptyer容器所需基础环境
docker exec elksj-jupyter /bin/bash -c 'pip install zat && pip install zat[pyspark] && pip install zat[all]'
docker exec elksj-jupyter /bin/bash -c 'pip install elasticsearch'
docker exec elksj-jupyter /bin/bash -c 'pip install pyhdfs -i http://pypi.douban.com/simple --trusted-host pypi.douban.com'
docker exec elksj-jupyter /bin/bash -c 'pip install tensorboardX && pip install transformers==4.9.0'
docker exec elksj-jupyter /bin/bash -c 'pip install transformers==4.9.0 && pip install nltk'

# 根据参数选择安装环境
read -p "请输入需要安装的训练环境（gpu/cpu）: " w
[[ $w = "gpu" ]] && a="g"
[[ $w = "cpu" ]] && a="c"

case $a in
g)
        echo "正在安装GPU训练环境!"
		docker exec elksj-jupyter /bin/bash -c 'pip install torch==1.6.0+cu101 torchvision==0.7.0+cu101 -f https://download.pytorch.org/whl/torch_stable.html'
;;
c)
        echo "正在安装CPU训练环境！"
		docker exec elksj-jupyter /bin/bash -c 'pip install torch==1.5.1+cpu torchvision==0.6.1+cpu -f https://download.pytorch.org/whl/torch_stable.html'
		docker exec elksj-jupyter /bin/bash -c 'pip3 install tensorflow==2.0 -i https://pypi.tuna.tsinghua.edu.cn/simple'
;;
*)
        echo "输入有误！请指定'gpu'或者'cpu'以便安装对应环境"
esac


# 使juptyer容器与docker-hadoop网络打通连接
if [[ -n $(docker network list -q -f "name=^hadoop_default$") ]];then
	echo "hadoop网络存在,进行连接"
    docker network connect hadoop_default elksj-jupyter
else
	echo "hadoop网络不存在，启动hadoop并连接"
	cd ${parent_dir}/hadoop
	bash hadoop_run.sh
	docker network connect hadoop_default elksj-jupyter

fi

# 解除HDFS安全模式
docker exec namenode /bin/bash -c 'hadoop dfsadmin -safemode leave'

# 查看当前容器网络列表
docker network list
# 查看hadoop容器网络状态
docker network inspect hadoop_default

# 查看容器状态
docker ps -a



