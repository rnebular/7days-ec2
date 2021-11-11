#!/bin/bash
# Restoring worlds from s3
cd /root/.local/share/7DaysToDie/Saves/Navezgane/
aws s3 cp "s3://8dot3/7days/Saves/My Game" . --recursive
