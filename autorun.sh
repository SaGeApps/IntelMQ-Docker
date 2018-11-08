#!/bin/bash
git clone https://github.com/SaGeApps/IntelMQ-Docker.git
cd IntelMQ-Docker
docker build -t "sage:intelmq" .
docker run -p 8081:80 -d sage:intelmq
firefox "127.0.0.1:8081"
#sudo apt install nfs-kernel-server
#echo "$(pwd)	*(rw,sync,no_subtree_check)"