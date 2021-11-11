#!/bin/bash
cd /root/.local/share/7DaysToDie/Saves/Navezgane/
aws s3 cp "My Game" "s3://8dot3/7days/Saves/My Game" --recursive
