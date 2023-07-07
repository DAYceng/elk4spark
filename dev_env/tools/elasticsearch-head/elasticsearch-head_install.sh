#!/bin/bash
cur_dir=$(cd $(dirname $0)  && pwd)
parent_dir=$(cd $(dirname $0) && cd .. && pwd)

# 下载源码
# git clone https://github.com/mobz/elasticsearch-head.git
rm -rf ${cur_dir}/elasticsearch-head
tar zxvf ${cur_dir}/elasticsearch-head.tar.gz -C ${cur_dir}/

# 编译安装
apt -y install npm 

apt -y install phantomjs
export QT_QPA_PLATFORM='offscreen'    # 防止出错：qt.qpa.screen: QXcbConnection: Could not connect to display

cd ${cur_dir}/elasticsearch-head
npm cache clean -f
npm install -g n
n v14.15.0
PATH="$PATH"

npm install

# 运行elasticsearch-head 
# npm run start
cd ${cur_dir}/
bash elasticsearch-head_run.sh