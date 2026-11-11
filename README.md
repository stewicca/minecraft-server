# Cross-Play Minecraft, powered by Docker

A Vanilla+ survival server (Paper) with Java/Bedrock cross-play, running in Docker.

## Getting started

Run `setup.sh` to set up the server.

## What's included

| Feature | Provided by |
| --- | --- |
| Bedrock cross-play | Geyser, Floodgate |
| Newer Java clients | ViaVersion |
| `/spawn`, `/home` (3 homes), `/tpa`, `/back` (also after death) | EssentialsX, EssentialsXSpawn |
| `/sit`, `/lay`, `/crawl`, sitting on stairs and slabs | GSit |
| Creepers, endermen and ghasts don't destroy blocks | VanillaTweaks *anti creeper/enderman/ghast grief* datapacks |
| Graves that keep your items on death | VanillaTweaks *graves* datapack |
| Player and mob head drops | VanillaTweaks *player head drops* and *more mob heads* datapacks |
| One player sleeping skips the night | `players_sleeping_percentage` gamerule |
| World pre-generation (`/chunky`) | Chunky |
| Permissions | LuckPerms |

Player permissions and the sleep gamerule are set in `RCON_CMDS_STARTUP` in `docker-compose.yml` and re-applied on every start.
The datapacks are listed in `extras/vanillatweaks.json`; when you change `VERSION`, change the `version` in that file to match.

After the first start, stand where new players should appear and run `/setspawn`.

## Updating

Run `update.sh` to pull the latest server image and plugins (`plugins.sh` downloads the plugins).

## Backups

Run `backup.sh` to create a backup.
