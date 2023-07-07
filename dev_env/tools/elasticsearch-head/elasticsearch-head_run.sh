#!/bin/bash
cur_dir=$(cd $(dirname $0)  && pwd)
parent_dir=$(cd $(dirname $0) && cd .. && pwd)

if [ -d "${cur_dir}/elasticsearch-head" ]; then
    # 先停止正在运行的
    kill -9 $(netstat -nlp | grep :9100 | awk '{print $7}' | awk -F"/" '{ print $1 }') 

    # 运行elasticsearch-head 
    cd ${cur_dir}/elasticsearch-head
    # npm run start     # 当前窗口运行
    nohup npm start &   # 后台运行

    # 检查服务端口是否正常
    sleep 1s
    netstat -antl | grep 9100

else
  echo "需要先运行：bash elasticsearch-head_install.sh"
fi


