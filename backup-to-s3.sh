#!/bin/bash
cd /root/.local/share/7DaysToDie/Saves/Navezgane/
aws s3 cp "Warm Office Server" "s3://8dot3/7days/Saves/Warm Office Server" --recursive
