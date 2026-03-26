#!/bin/sh

mkdir -p ./backups
chmod +x ./backup.sh
cp .env.example .env

. ./.env
sed -i "s|  server-name: .*|  server-name: \"${SERVER_NAME}\"|" ./data/plugins/Geyser-Spigot/config.yml

curl -L -o ./data/plugins/Geyser-Spigot.jar https://download.geysermc.org/v2/projects/geyser/versions/latest/builds/latest/downloads/spigot --keepalive-time 60 &
curl -L -o ./data/plugins/floodgate-spigot.jar https://download.geysermc.org/v2/projects/floodgate/versions/latest/builds/latest/downloads/spigot --keepalive-time 60 &
curl -L -o ./data/plugins/ViaVersion.jar https://hangarcdn.papermc.io/plugins/ViaVersion/ViaVersion/versions/5.7.2/PAPER/ViaVersion-5.7.2.jar --keepalive-time 60 &
wait

ln -sf ../floodgate/key.pem ./data/plugins/Geyser-Spigot/key.pem

docker compose up -d
