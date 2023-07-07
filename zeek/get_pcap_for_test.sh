#!/bin/bash
cur_dir=$(cd $(dirname $0)  && pwd)
parent_dir=$(cd $(dirname $0) && cd .. && pwd)

mkdir -p ${cur_dir}/pcap

# test.pcap, 0.07 MB
cd ${cur_dir}/pcap
if [ ! -f "test.pcap" ]; then
  wget https://s3.amazonaws.com/tcpreplay-pcap-files/test.pcap
else
  echo "The file of test.pcap has downloaded!"
fi

# smallFlows.pcap, 9.4 MB
# cd ${cur_dir}/pcap
# if [ ! -f "smallFlows.pcap" ]; then
#   wget https://s3.amazonaws.com/tcpreplay-pcap-files/smallFlows.pcap
# else
#   echo "The file of smallFlows.pcap has downloaded!"
# fi

# heartbleed.pcap, 0.06 MB
cd ${cur_dir}/pcap
if [ ! -f "heartbleed.pcap" ]; then
  wget https://github.com/blacktop/docker-zeek/raw/master/pcap/heartbleed.pcap
else
  echo "The file of heartbleed.pcap has downloaded!"
fi
