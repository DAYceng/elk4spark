#!/bin/bash

IP_ADDR=$(hostname -I | cut -d ' ' -f1) 
echo $IP_ADDR

cp /opt/kafka/config/server.properties_template /opt/kafka/config/server.properties
/bin/sed -i 's/IP_ADDR/'''$IP_ADDR'''/g' /opt/kafka/config/server.properties

kafka-server-start.sh /opt/kafka/config/server.properties