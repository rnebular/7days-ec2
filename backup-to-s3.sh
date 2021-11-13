#!/bin/bash
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

# backup from local to s3, and then from s3 timestamp to s3 latest
cd /root/.local/share/7DaysToDie/Saves/Navezgane/
aws s3 cp "My Game" "s3://8dot3/7days/Saves/My Game/$TIMESTAMP" --recursive
aws s3 cp "s3://8dot3/7days/Saves/My Game/$TIMESTAMP" "s3://8dot3/7days/Saves/My Game/latest" --recursive
