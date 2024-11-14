#!/bin/sh

# If you're using Vultr, add this file to the startup scripts, link down below
# https://my.vultr.com/startup/

#========================================================================================#
# Uncomment the commands below if you're running this from a newly created server
#========================================================================================#

# Uncomment this if you want to create a swapfile
# 4G means 4GB of disk space
# You can use M to denote MB
fallocate -l 4G /swapfile
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
echo "/swapfile swap swap defaults 0 0" >> /etc/fstab

# # Uncomment this if you want to change the port of SSH
# # You can use ports other than 22
# # Your choice is up to 65536, as long the port is open
# ufw allow 22/tcp
# sed -i 's/#Port 22/Port 22/g' /etc/ssh/sshd_config
# systemctl restart ssh

# # Make the folder
# mkdir -p /home/user/apps

# # Go to the folder
# cd /home/user/apps

# # Clone the repo
# git clone https://github.com/drixlerangelo/cross-play-minecraft-docker.git

# # Go to the repo
# cd ./cross-play-minecraft-docker

# Make the backup folder
mkdir ./backups

# Make the backup script executable
chmod +x ./backup.sh

# Copy the .env.example file
cp .env.example .env


#========================================================================================#
# Uncomment the commands below if you have set up a backup from cloud storage
#========================================================================================#

# # If you have a Dropbox account, you can your backup like so
# # Be sure to change the filename to latest.tar.gz
# # Change the filename below if you save it differently
# curl -L -o ./backups/latest.tar.gz https://www.dropbox.com/s/xxxxxxxxxxxxxxx/latest.tar.gz?dl=1

# # Extract the contents of the backup to the data folder
# # Change the filename below if you save it differently
# tar xvzf ./backups/latest.tar.gz -C ./data

# # You can delete these files before replacing them
# # if you have a specific config for your server
# rm ./.env ./docker-compose.yml \
#     ./data/ops.json ./data/server-icon.png \
#     ./data/server.properties ./data/whitelist.json

# # Download your configuration file
# curl -L -o ./config.tar.gz https://www.dropbox.com/s/xxxxxxxxxxxxxxx/config.tar.gz?dl=1

# # Extract the contents of your configuration file
# tar xvzf ./config.tar.gz -C ./


#========================================================================================#
# You can also make specific file changes
#========================================================================================#

# # Increase/Decrease mobs depending on the server's resources (or just the RAM :D)
# sed -i 's/monsters: .*/monsters: 200/g' data/bukkit.yml

#========================================================================================#
# Download or update the plugins that enable Bedrock players to use this server
#========================================================================================#

# Remove the current GeyserMC and Floodgate plugins
rm -f ./data/plugins/Geyser-Spigot.jar ./data/plugins/floodgate-spigot.jar

# Download the latest GeyserMC and Floodgate plugins
curl -L -o ./data/plugins/Geyser-Spigot.jar https://download.geysermc.org/v2/projects/geyser/versions/latest/builds/latest/downloads/spigot --keepalive-time 60
curl -L -o ./data/plugins/floodgate-spigot.jar https://download.geysermc.org/v2/projects/floodgate/versions/latest/builds/latest/downloads/spigot --keepalive-time 60

# Custom plugins
curl -L -o ./data/plugins/ViaVersion.jar https://hangarcdn.papermc.io/plugins/ViaVersion/ViaVersion/versions/5.1.1/PAPER/ViaVersion-5.1.1.jar --keepalive-time 60
curl -L -o ./data/plugins/ServerEssentials.jar https://mediafilez.forgecdn.net/files/5891/12/ServerEssentials-Bukkit.jar --keepalive-time 60
curl -L -o ./data/plugins/LuckPerms.jar https://download.luckperms.net/1561/bukkit/loader/LuckPerms-Bukkit-5.4.146.jar --keepalive-time 60
curl -L -o ./data/plugins/WorldEdit.jar https://mediafilez.forgecdn.net/files/5830/450/worldedit-bukkit-7.3.8.jar --keepalive-time 60
curl -L -o ./data/plugins/SpawnerSilk.jar https://mediafilez.forgecdn.net/files/5491/938/spawner-silk-5.8.0.jar --keepalive-time 60
curl -L -o ./data/plugins/DeadChest.jar https://mediafilez.forgecdn.net/files/5502/330/dead-chest-4.21.1.jar --keepalive-time 60
curl -L -o ./data/plugins/Clearlag.jar https://mediafilez.forgecdn.net/files/3198/633/Clearlag.jar --keepalive-time 60

# Add a symbolic link for the key file
cd data/plugins

ln -s ../floodgate/key.pem Geyser-Spigot/key.pem
cd ../..


#========================================================================================#
# And for the finale, start the server
#========================================================================================#

# Up the container
docker-compose up -d


#========================================================================================#
# Optional: Want to play with friends but don't have that cha-ching to rent a server?
# Use a private network like ZeroTier. (PS: I'm not an affiliate of them)
#========================================================================================#

# # Install ZeroTier
# curl -s 'https://raw.githubusercontent.com/zerotier/ZeroTierOne/master/doc/contact%40zerotier.com.gpg' | gpg --import && if z=$(curl -s 'https://install.zerotier.com/' | gpg); then echo "$z" | sudo bash; fi

# # Join the network
# zerotier-cli join xxxxxxxxxxxxxxxx

#========================================================================================#
# Glad this setup script made it this far. Congrats!
#========================================================================================#
