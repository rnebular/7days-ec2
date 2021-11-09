#!/bin/bash
# Restoring worlds from s3
cd ~/.config/unity3d/IronGate/Valheim/worlds
aws s3 cp s3://8dot3/valheim/worlds/ . --recursive
