#!/bin/sh

docker compose down

VIAVERSION=$(curl -s https://hangar.papermc.io/api/v1/projects/ViaVersion/latestrelease)
LUCKPERMS=$(curl -s https://metadata.luckperms.net/data/all | grep -o '"bukkit":"[^"]*"' | cut -d'"' -f4)
ESSENTIALSX=$(curl -s https://api.github.com/repos/EssentialsX/Essentials/releases/latest | grep -o '"browser_download_url": "https://github\.com[^"]*EssentialsX-[0-9][0-9.]*\.jar"' | grep -o 'https://[^"]*')
VAULT=$(curl -s https://api.github.com/repos/MilkBowl/Vault/releases/latest | grep -o '"browser_download_url": "https://github\.com[^"]*\.jar"' | head -1 | grep -o 'https://[^"]*')

curl -L -o ./data/plugins/Geyser-Paper.jar https://download.geysermc.org/v2/projects/geyser/versions/latest/builds/latest/downloads/spigot --keepalive-time 60 &
curl -L -o ./data/plugins/floodgate-spigot.jar https://download.geysermc.org/v2/projects/floodgate/versions/latest/builds/latest/downloads/spigot --keepalive-time 60 &
curl -L -o ./data/plugins/ViaVersion.jar "https://hangarcdn.papermc.io/plugins/ViaVersion/ViaVersion/versions/${VIAVERSION}/PAPER/ViaVersion-${VIAVERSION}.jar" --keepalive-time 60 &
curl -L -o ./data/plugins/LuckPerms.jar "${LUCKPERMS}" --keepalive-time 60 &
curl -L -o ./data/plugins/EssentialsX.jar "${ESSENTIALSX}" --keepalive-time 60 &
curl -L -o ./data/plugins/Vault.jar "${VAULT}" --keepalive-time 60 &
wait

docker compose up -d
