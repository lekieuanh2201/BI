FROM ubuntu:22.04

WORKDIR /root

# install ssh, openjdk, wget
RUN apt-get update && apt-get install -y openssh-server openssh-client openjdk-8-jdk wget

# generate ssh-key to connect without key
RUN ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa && \
    cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys

# install hadoop 3.2.4
RUN wget https://dlcdn.apache.org/hadoop/common/hadoop-3.2.4/hadoop-3.2.4.tar.gz && \
    tar -xzf hadoop-3.2.4.tar.gz && \
    mv hadoop-3.2.4 /usr/local/hadoop

# set environment variable
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
ENV HADOOP_HOME=/usr/local/hadoop
ENV PATH=$PATH:/usr/local/hadoop/bin:/usr/local/hadoop/sbin
ENV HADOOP_MAPRED_HOME=${HADOOP_HOME}
ENV HADOOP_COMMON_HOME=${HADOOP_HOME}
ENV HADOOP_HDFS_HOME=${HADOOP_HOME}
ENV YARN_HOME=${HADOOP_HOME}

RUN mkdir -p ~/hdfs/namenode && \ 
    mkdir -p ~/hdfs/datanode && \
    mkdir $HADOOP_HOME/logs

# Replace hadoop config files
COPY config/* /tmp/

RUN mv /tmp/hadoop-env.sh ${HADOOP_HOME}/etc/hadoop/hadoop-env.sh && \
    mv /tmp/core-site.xml ${HADOOP_HOME}/etc/hadoop/core-site.xml && \
    mv /tmp/hdfs-site.xml ${HADOOP_HOME}/etc/hadoop/hdfs-site.xml && \
    mv /tmp/mapred-site.xml ${HADOOP_HOME}/etc/hadoop/mapred-site.xml && \
    mv /tmp/yarn-site.xml ${HADOOP_HOME}/etc/hadoop/yarn-site.xml && \
    mv /tmp/masters ${HADOOP_HOME}/etc/hadoop/masters && \
    mv /tmp/workers ${HADOOP_HOME}/etc/hadoop/workers

RUN chmod +x $HADOOP_HOME/sbin/start-dfs.sh && \
    chmod +x $HADOOP_HOME/sbin/start-yarn.sh 

# format namenode
RUN /usr/local/hadoop/bin/hdfs namenode -format

# RUN service ssh start 
CMD [ "sh", "-c", "service ssh start; bash"]

