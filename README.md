# Cross-Play Minecraft, powered by Docker

A public survival server (Purpur) built on the Celestial Survival setup, with Java/Bedrock cross-play and Vanilla+ extras, running in Docker.

## Getting started

1. Run `setup.sh` to create `.env` and the plugin folders, then fill in the passwords and `PLAYIT_SECRET` in `.env`.
2. Download **Celestial Survival** from BuiltByBit. Its licence forbids sharing it, so it is not in this repo. Then install it:

   ```sh
   ./install-celestial.sh "/path/to/Celestial Survival Free 1.1.0.zip"
   ```

   This backs up `./data` to `./backups`, **deletes the current world**, copies the setup into `./data`, downloads the extra plugins and starts the server.
3. Give yourself operator from the console: `docker exec minecraft-server rcon-cli op <name>`.
4. Follow the Celestial README for voting, ranks and replacing the server name.

## What's included

The Celestial setup brings the spawn and AFK worlds, ranks, claims (GriefPrevention), shops, auctions, crates, voting, RTP, combat logging, tab list and more. On top of it we add:

| Feature | Provided by |
| --- | --- |
| Bedrock cross-play | Geyser, Floodgate |
| `/register` and `/login` for offline-mode accounts | AuthMe Reloaded |
| Tab list and shop that the setup expects | TAB, UltimateShop |
| `/back` after death | `essentials.back.ondeath` for the default group |
| `/sit`, `/lay`, `/crawl` | GSit |
| Creepers, endermen and ghasts don't destroy blocks | VanillaTweaks *anti creeper/enderman/ghast grief* datapacks |
| Graves that keep your items on death | VanillaTweaks *graves* datapack |
| Player and mob head drops | VanillaTweaks *player head drops* and *more mob heads* datapacks |
| One player sleeping skips the night | `players_sleeping_percentage` gamerule |
| World pre-generation (`/chunky`) | Chunky |

The gamerule, the Nether/End world borders and the `/back` permissions are set in `RCON_CMDS_STARTUP` in `docker-compose.yml` and re-applied on every start.
The datapacks are listed in `extras/vanillatweaks.json`; when you change `VERSION`, change the `version` in that file to match.

## Updating

Run `update.sh` to pull the latest server image and the extra plugins (`plugins.sh`). The Celestial plugins are updated by installing a newer Celestial release.

## Resetting the world

Run `reset.sh` to regenerate the survival world. The spawn and AFK worlds, borders and seed are kept; homes, claims and inventories are cleared.

## Backups

Run `backup.sh` to create a backup.
