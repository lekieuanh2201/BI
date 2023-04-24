## 1. Build base image
```bash
docker build -t hadoop-base .
```
## 2. Run docker compose
```bash
docker-compose up -d
```
## !NOTE
ssh may not be running on docker container, access each container and start the ssh service:
```bash
docker exec -it [container-name] bash
service ssh start
```
## 3. Start HDFS cluster
Start the HDFS by running the ```start-dfs.sh``` script from Name Node Server (namenode):
```bash
start-dfs.sh
```
Using ```jps``` to check if the HDFS cluster is running
Access ```http://localhost:9870``` to view namenode web UI
## 4. Upload File to HDFS (1GB)
First, manually create your home directory. All other commands will use a path relative to this default home directory:
```bash
hdfs dfs -mkdir -p /user/[your-username]/
```
Create text file 1GB
```bash
fallocate -l 1G filename.txt
```
Upload file to hdfs using -put option
```bash
hdfs dfs -put filename.txt
```
List a file on hdfs
```bash
hdfs dfs -ls
```
