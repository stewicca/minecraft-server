#!/bin/sh

# If you're having permission issues, run this script in sudo.
trap 'docker exec minecraft-server rcon-cli save-on' EXIT
mkdir -p backups
docker exec minecraft-server rcon-cli save-off
docker exec minecraft-server rcon-cli save-all
tar --create --gzip --directory="./data" --file="./backups/backup_$(date '+%Y%m%d%H%M').tar.gz" "./"
