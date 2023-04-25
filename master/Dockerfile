FROM hadoop-base:latest

WORKDIR /root

# RUN service ssh start
# CMD ["hadoop", "namenode"]
ADD run.sh /bin/run.sh
# ADD run.sh /run.sh
RUN chmod +x /bin/run.sh

ENTRYPOINT ["run.sh"]

