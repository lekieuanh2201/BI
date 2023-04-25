FROM hadoop-base:latest

WORKDIR /root

ADD run.sh /bin/run.sh
# ADD run.sh /run.sh
RUN chmod +x /bin/run.sh

ENTRYPOINT ["run.sh"]


# CMD ["hadoop", "datanode"]

