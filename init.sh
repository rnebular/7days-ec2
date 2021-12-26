#!/bin/bash
# startup user data for ec2 instance.
sudo yum update -y

# Install SteamCMD pre-reqs
sleep 10
sudo yum install -y glibc.i686 libstdc++48.i686

# create location for games and download s3 scripts
sudo mkdir /games
sudo mkdir /games/7days2die && cd /games/7DaysToDie
sudo aws s3 cp s3://8dot3/7days/backup-to-s3.sh .
sudo aws s3 cp s3://8dot3/7days/restore-from-s3.sh .
sudo chmod +x ./backup-to-s3.sh
sudo chmod +x ./restore-from-s3.sh


# Create SteamCMD directory
sudo mkdir ~/steamcmd && cd ~/steamcmd

# Download SteamCMD
sudo wget 'https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz'

# Unpack SteamCMD
sudo tar -xzvf steamcmd_linux.tar.gz && sudo rm -f steamcmd_linux.tar.gz

export templdpath=$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=./linux64:$LD_LIBRARY_PATH
export SteamAppId="294420" # -beta latest_experimental

# Launch SteamCMD and update 7 Days to Die (gameid=294420 )
sudo ./steamcmd.sh +login anonymous +force_install_dir /games/7days2die +app_update $SteamAppId validate +quit

# copy server config file from s3
cd /games/7days2die
sudo aws s3 cp s3://8dot3/7days/serverconfig_a20.xml ./serverconfig.xml
sudo aws s3 cp s3://8dot3/7days/7days.service .
sudo chmod +x ./serverconfig.xml
sudo chmod +x ./7days.service

sudo cp 7days.service /etc/systemd/system
sudo systemctl start 7days

# Restores latest backup:
# (location on instance) /root/.local/share/7DaysToDie/Saves/Navezgane/My Game/
# copy Save files from s3
sudo ./restore-from-s3.sh
sudo sleep 10; sudo systemctl restart 7days
sudo systemctl enable 7days

# create cron for auto-backup
cat > /etc/cron.d/7days-backup << EOF
SHELL=/bin/bash 
PATH=/sbin:/bin:/usr/sbin:/usr/bin 
MAILTO=root HOME=/  
*/30 * * * * root ./games/7daysToDie/backup-to-s3.sh
EOF
