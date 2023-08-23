#!/bin/bash
sudo yum update -y
sudo timedatectl set-timezone Asia/Kolkata
sudo yum install -y yum-utils git
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo systemctl start docker
sudo systemctl enable docker
sudo groupadd docker
sudo usermod -aG docker vagrant
newgrp docker
git clone https://github.com/zabbix/zabbix-docker.git
cd zabbix-docker
git checkout $ZABBIX_VERSION
docker compose --profile all -f ./docker-compose_v3_alpine_mysql_latest.yaml up -d