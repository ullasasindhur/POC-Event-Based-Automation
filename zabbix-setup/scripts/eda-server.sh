#!/bin/bash
cd eda-server
git pull
cd tools/docker
docker compose -p eda -f docker-compose-stage.yaml pull
docker compose -p eda -f docker-compose-stage.yaml up -d