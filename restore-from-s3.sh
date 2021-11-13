#!/bin/bash
# Restoring worlds from s3 latest, will need to make this script do TIMESTAMP based lookups with input?
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

cd /root/.local/share/7DaysToDie/Saves/Navezgane/
aws s3 cp "s3://8dot3/7days/Saves/My Game/latest" . --recursive
