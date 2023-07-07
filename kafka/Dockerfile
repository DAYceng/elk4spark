FROM blacktop/kafka:0.11

ENV KAFKA_HOME=/opt/kafka

WORKDIR /opt/kafka
ENV PATH=${PATH}:${KAFKA_HOME}/bin

RUN mkdir -p /opt/kafka/config
RUN mkdir -p /entrypoint

ENTRYPOINT ["/entrypoint/entrypoint.sh"]
