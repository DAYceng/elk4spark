#!/bin/bash
cur_dir=$(cd $(dirname $0)  && pwd)
parent_dir=$(cd $(dirname $0) && cd .. && pwd)

if [ -d "${cur_dir}/tools/elasticsearch-head/elasticsearch-head" ]; then
    echo "已存在则运行：${cur_dir}/tools/elasticsearch-head/elasticsearch-head"

    # 运行elasticsearch-head 
    cd ${cur_dir}/tools/elasticsearch-head/
    bash elasticsearch-head_run.sh
    
else
    echo "不存在则安装：${cur_dir}/tools/elasticsearch-head/elasticsearch-head"
    
    # 运行elasticsearch-head 
    cd ${cur_dir}/tools/elasticsearch-head/
    bash elasticsearch-head_install.sh
fi


