#!/bin/bash
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

# backup from local to s3, and then from s3 timestamp to s3 latest
cd /root/.local/share/7DaysToDie/Saves/Nuwekahi Mountains/
aws s3 cp "WarmOffice" "s3://8dot3/7days/Saves/Nuwekahi Mountains/$TIMESTAMP" --recursive
aws s3 cp "s3://8dot3/7days/Saves/WarmOffice/$TIMESTAMP" "s3://8dot3/7days/Saves/WarmOffice/latest" --recursive
