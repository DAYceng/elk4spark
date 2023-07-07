#!/bin/bash
cur_dir=$(cd $(dirname $0)  && pwd)
parent_dir=$(cd $(dirname $0) && cd .. && pwd)

apt update

# 确保python3和pip3
rm -rf /usr/bin/python
ln -s /usr/bin/python3 /usr/bin/python
apt-get -y install python3-pip vim wget net-tools 

python -m pip install -U pip -i  http://mirrors.aliyun.com/pypi/simple/ --trusted-host mirrors.aliyun.com 
rm -rf /usr/bin/pip
ln -s /usr/bin/pip3 /usr/bin/pip

# 安装docker
apt-get -y install docker.io 
mkdir -p  /etc/docker/
cat <<EOF | tee /etc/docker/daemon.json
{
        "registry-mirrors":["https://pee6w651.mirror.aliyuncs.com"],
        "exec-opts": ["native.cgroupdriver=systemd"]
}
EOF
systemctl daemon-reload
systemctl restart docker.service

groupadd docker
gpasswd -a $USER docker
#newgrp docker
docker ps                          # 测试docker命令是否可以使用sudo正常使用

# 安装docker-compose
pip3 install -U docker-compose

# 安装其它依赖包
pip3 install ipykernel pyspark pandas -i  http://mirrors.aliyun.com/pypi/simple/ --trusted-host mirrors.aliyun.com
