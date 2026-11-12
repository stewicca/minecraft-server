#!/bin/sh
# Install the Celestial Survival setup into ./data.
# The setup is not part of this repo (its licence forbids sharing it); download it from BuiltByBit and run:
#   ./install-celestial.sh "/path/to/Celestial Survival Free 1.1.0.zip"
# This deletes the current world. Everything in ./data is backed up to ./backups first.

set -e

[ -f "$1" ] || { echo "Usage: $0 <Celestial Survival zip or its server.zip>" >&2; exit 1; }
command -v unzip >/dev/null || { echo "unzip is required" >&2; exit 1; }

TMP=$(mktemp -d)
trap 'rm -rf "$TMP"' EXIT
unzip -q "$1" -d "$TMP/download"
SETUP="$TMP/download"
# The BuiltByBit download wraps server.zip together with the README
if [ -f "$SETUP/server.zip" ]; then
    unzip -q "$SETUP/server.zip" -d "$TMP/server"
    SETUP="$TMP/server"
fi
[ -d "$SETUP/plugins" ] && [ -d "$SETUP/world" ] || { echo "$1 does not look like the Celestial Survival setup" >&2; exit 1; }

docker compose down

mkdir -p backups
if [ -n "$(ls -A data 2>/dev/null)" ]; then
    BACKUP="backups/before-celestial_$(date '+%Y%m%d%H%M').tar.gz"
    tar --create --gzip --file="$BACKUP" --directory=data .
    echo "Old server data backed up to $BACKUP"
fi

# Start from a fresh world, and drop player data that pointed into it
rm -rf data/world data/world_nether data/world_the_end data/plugins/Essentials/userdata

mkdir -p data
cp -a "$SETUP/." data/

./plugins.sh
ln -sf ../floodgate/key.pem ./data/plugins/Geyser-Spigot/key.pem

docker compose up -d
