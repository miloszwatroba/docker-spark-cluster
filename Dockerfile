FROM java:8-jdk-alpine

ENV DAEMON_RUN=true
ENV SPARK_VERSION=2.4.2
ENV HADOOP_VERSION=2.7
ENV SPARK_URL=http://apache.mirror.triple-it.nl/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz

ENV SCALA_VERSION=2.12.8
ENV SCALA_URL=https://downloads.typesafe.com/scala/${SCALA_VERSION}/scala-${SCALA_VERSION}.tgz

ENV SBT_VERSION=1.2.8
ENV SBT_URL=https://piccolo.link/sbt-${SBT_VERSION}.tgz

RUN apk add --no-cache --virtual=.build-dependencies wget ca-certificates && \
    apk add --no-cache bash curl jq && \
    cd "/tmp" && \
    wget --no-verbose ${SCALA_URL} && \
    tar xzf "scala-${SCALA_VERSION}.tgz" && \
    mkdir -p "/usr/local/scala" && \
    rm "/tmp/scala-${SCALA_VERSION}/bin/"*.bat && \
    mv "/tmp/scala-${SCALA_VERSION}/bin" "/tmp/scala-${SCALA_VERSION}/lib" "/usr/local/scala" && \
    ln -s "/usr/local/scala/bin/"* "/usr/bin/" && \
    apk del .build-dependencies && \
    rm -rf "/tmp/"* && \
    scala -version

RUN apk --update add ca-certificates wget tar && \
    mkdir -p "/usr/local/sbt" && \
    wget -qO - --no-check-certificate ${SBT_URL} | tar xz -C "/usr/local/sbt" --strip-components=1 && \
    ln -s "/usr/local/sbt/bin/"* "/usr/bin/" && \
    sbt sbtVersion

RUN apk add --no-cache python3

RUN wget --no-verbose ${SPARK_URL} &&\
    tar -xvzf "spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz" && \
    mv "spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}" "/spark" && \
    rm "spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz" && \
    /spark/bin/spark-shell --version


