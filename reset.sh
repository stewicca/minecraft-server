#!/bin/sh
# Reset the survival world (overworld, nether, end) while keeping the Celestial spawn and AFK worlds,
# the world borders and the seed. Player homes, claims and inventories are cleared too.

docker compose down
for dimension in overworld the_nether the_end; do
    rm -rf "./data/world/dimensions/minecraft/$dimension/region" \
        "./data/world/dimensions/minecraft/$dimension/entities" \
        "./data/world/dimensions/minecraft/$dimension/poi"
done
rm -rf ./data/world/players ./data/plugins/Essentials/userdata \
    ./data/plugins/GriefPreventionData/ClaimData ./data/plugins/GriefPreventionData/PlayerData
docker compose up -d
