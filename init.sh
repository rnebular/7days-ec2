#!/bin/bash
# startup user data for ec2 instance.
sudo yum update -y

# Install SteamCMD pre-reqs
sleep 10
sudo yum install -y glibc.i686 libstdc++48.i686

# create location for games
sudo mkdir /games
sudo mkdir /games/7days2die

# Create SteamCMD directory
sudo mkdir ~/steamcmd && cd ~/steamcmd

# Download SteamCMD
sudo wget 'https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz'

# Unpack SteamCMD
sudo tar -xzvf steamcmd_linux.tar.gz && sudo rm -f steamcmd_linux.tar.gz

export templdpath=$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=./linux64:$LD_LIBRARY_PATH
export SteamAppId=294420

# Launch SteamCMD and update 7 Days to Die (gameid=294420 )
sudo ./steamcmd.sh +login anonymous +force_install_dir /games/7days2die +app_update $SteamAppId validate +quit

# copy server config file from s3
cd /games/7days2die
sudo aws s3 cp s3://8dot3/7days/serverconfig.xml .
sudo aws s3 cp s3://8dot3/7days/7days.service .
sudo chmod +x ./serverconfig.xml
sudo chmod +x ./7days.service

sudo cp 7days.service /etc/systemd/system
sudo systemctl start 7days

# Restore saves:
# (location on instance) /root/.local/share/7DaysToDie/Saves/Navezgane/My Game/
# copy Save files from s3 (commented out)
sudo aws s3 cp "s3://8dot3/7days/Saves/" '/root/.local/share/7DaysToDie/Saves/Navezgane/My Game/' --recursive --force
sudo sudo systemctl restart 7days

# manual start game at CLI
# cd /games/7days2die
# sudo ./startserver.sh -configfile=serverconfig.xml
