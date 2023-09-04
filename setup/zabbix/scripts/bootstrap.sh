#!/bin/bash
cd zabbix-docker
git pull
git checkout $ZABBIX_VERSION
docker compose --profile all -f ./docker-compose_v3_alpine_mysql_latest.yaml up -d