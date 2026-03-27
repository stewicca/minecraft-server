#!/bin/sh

mkdir -p ./backups
chmod +x ./backup.sh
cp .env.example .env

. ./.env
sed -i "s|  server-name: .*|  server-name: \"${SERVER_NAME}\"|" ./data/plugins/Geyser-Paper/config.yml

VIAVERSION=$(curl -s https://hangar.papermc.io/api/v1/projects/ViaVersion/latestrelease)
LUCKPERMS=$(curl -s https://metadata.luckperms.net/data/all | grep -o '"bukkit":"[^"]*"' | cut -d'"' -f4)

curl -L -o ./data/plugins/Geyser-Paper.jar https://download.geysermc.org/v2/projects/geyser/versions/latest/builds/latest/downloads/spigot --keepalive-time 60 &
curl -L -o ./data/plugins/floodgate-spigot.jar https://download.geysermc.org/v2/projects/floodgate/versions/latest/builds/latest/downloads/spigot --keepalive-time 60 &
curl -L -o ./data/plugins/ViaVersion.jar "https://hangarcdn.papermc.io/plugins/ViaVersion/ViaVersion/versions/${VIAVERSION}/PAPER/ViaVersion-${VIAVERSION}.jar" --keepalive-time 60 &
curl -L -o ./data/plugins/LuckPerms.jar "${LUCKPERMS}" --keepalive-time 60 &
wait

ln -sf ../floodgate/key.pem ./data/plugins/Geyser-Paper/key.pem

docker compose up -d
