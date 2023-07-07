#!/bin/bash
cur_dir=$(cd $(dirname $0)  && pwd)
parent_dir=$(cd $(dirname $0) && cd .. && pwd)

# test.pcap, 0.07 MB
cd ${cur_dir}/pcap
if [ -f "test.pcap" ]; then
    echo "The file of test.pcap has been zeeking ......"
    docker run --rm \
         -v `pwd`:/pcap \
         --net elk_spark_elastinet \
         --link elksj-kafka:localhost\
         blacktop/zeek:kafka -r test.pcap local "Site::local_nets += { 192.168.11.0/24 }"
else
  echo "The file of test.pcap has not downloaded!"
fi

# smallFlows.pcap, 9.4 MB
# cd ${cur_dir}/pcap
# if [ -f "smallFlows.pcap" ]; then
#     echo "The file of smallFlows.pcap has been zeeking ......"
#     docker run --rm \
#          -v `pwd`:/pcap \
#          --net elk_spark_elastinet \
#          --link elksj-kafka:localhost\
#          blacktop/zeek:kafka -r smallFlows.pcap local "Site::local_nets += { 192.168.11.0/24 }"
# else
#     echo "The file of smallFlows.pcap has not downloaded!"
# fi

# heartbleed.pcap, 0.06 MB
cd ${cur_dir}/pcap
if [ -f "heartbleed.pcap" ]; then
    echo "The file of heartbleed.pcap has been zeeking ......"
    docker run --rm \
         -v `pwd`:/pcap \
         --net elk_spark_elastinet \
         --link elksj-kafka:localhost\
         blacktop/zeek:kafka -r heartbleed.pcap local "Site::local_nets += { 192.168.11.0/24 }"
else
    echo "The file of heartbleed.pcap has not downloaded!"
fi

cd ${cur_dir}/pcap
rm -rf *.log