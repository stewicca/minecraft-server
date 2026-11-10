#!/bin/sh

docker compose down
rm -rf ./data/world ./data/world_nether ./data/world_the_end
rm -rf ./data/plugins/Essentials/userdata ./data/plugins/Essentials/warps ./data/plugins/Essentials/spawn.yml
docker compose up -d
