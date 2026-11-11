#!/bin/sh

mkdir -p ./backups ./data/plugins/Geyser-Spigot ./data/plugins/floodgate
git checkout -- ./data/plugins/Geyser-Spigot/config.yml ./data/plugins/floodgate/config.yml 2>/dev/null || true
chmod +x ./backup.sh ./update.sh ./reset.sh ./plugins.sh
[ -f .env ] || cp .env.example .env

. ./.env
sed -i "s|  server-name: .*|  server-name: \"${SERVER_NAME}\"|" ./data/plugins/Geyser-Spigot/config.yml

./plugins.sh

ln -sf ../floodgate/key.pem ./data/plugins/Geyser-Spigot/key.pem

docker compose up -d
