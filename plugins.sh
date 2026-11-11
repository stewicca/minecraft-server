#!/bin/sh
# Download the latest version of every plugin into ./data/plugins.
# Called by setup.sh and update.sh; the server must be stopped or restarted afterwards.

command -v python3 >/dev/null || { echo "python3 is required by plugins.sh" >&2; exit 1; }

PLUGINS=./data/plugins
mkdir -p "$PLUGINS"

# Jars left behind by older versions of these scripts
rm -f "$PLUGINS/Geyser-Paper.jar"

# Latest release jar of a Modrinth project built for Paper (regardless of the Minecraft versions it lists)
modrinth() {
    curl -fsS "https://api.modrinth.com/v2/project/$1/version?loaders=%5B%22paper%22%5D&include_changelog=false" |
        python3 -c 'import sys, json
version = next(v for v in json.load(sys.stdin) if v["version_type"] == "release")
print(next(f for f in version["files"] if f["primary"])["url"])'
}

github_asset() {
    curl -fsS "https://api.github.com/repos/$1/releases/latest" | grep -o '"browser_download_url": "[^"]*"' | cut -d'"' -f4 | grep "$2" | head -1
}

VIAVERSION=$(curl -fsS https://hangar.papermc.io/api/v1/projects/ViaVersion/latestrelease)
LUCKPERMS=$(curl -fsS https://metadata.luckperms.net/data/all | grep -o '"bukkit":"[^"]*"' | cut -d'"' -f4)
ESSENTIALSX=$(github_asset EssentialsX/Essentials '/EssentialsX-[0-9][^/]*\.jar$')
ESSENTIALSX_SPAWN=$(github_asset EssentialsX/Essentials '/EssentialsXSpawn-[0-9][^/]*\.jar$')
VAULT=$(github_asset MilkBowl/Vault '\.jar$')
GSIT=$(modrinth gsit)
CHUNKY=$(modrinth chunky)

download() {
    if [ -z "$2" ]; then
        echo "Could not find a download for $1, keeping the current jar" >&2
        return
    fi
    curl -fsSL --keepalive-time 60 -o "$PLUGINS/$1.jar.part" "$2" && mv "$PLUGINS/$1.jar.part" "$PLUGINS/$1.jar" ||
        { rm -f "$PLUGINS/$1.jar.part"; echo "Download of $1 failed, keeping the current jar" >&2; }
}

download Geyser-Spigot https://download.geysermc.org/v2/projects/geyser/versions/latest/builds/latest/downloads/spigot &
download floodgate-spigot https://download.geysermc.org/v2/projects/floodgate/versions/latest/builds/latest/downloads/spigot &
download ViaVersion "${VIAVERSION:+https://hangarcdn.papermc.io/plugins/ViaVersion/ViaVersion/versions/${VIAVERSION}/PAPER/ViaVersion-${VIAVERSION}.jar}" &
download LuckPerms "$LUCKPERMS" &
download EssentialsX "$ESSENTIALSX" &
download EssentialsXSpawn "$ESSENTIALSX_SPAWN" &
download Vault "$VAULT" &
download GSit "$GSIT" &
download Chunky "$CHUNKY" &
wait
