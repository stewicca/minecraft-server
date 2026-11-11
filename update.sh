#!/bin/sh

docker compose down
docker compose pull

./plugins.sh

docker compose up -d
