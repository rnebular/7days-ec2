#!/bin/sh
# checking the local server for what number of players are online, via telnet
telnet_output="$({ echo 'listplayers'; sleep 2; echo $'exit'; } | telnet localhost 8081 2>&1)"
echo $telnet_output

number_online_raw=${telnet_output##*"Total of"}
number_online="$(echo $number_online_raw | cut -c 1)"
echo $number_online

if [ $number_online -gt 0 ]
then
    echo "$number_online player(s) online, waiting to shut down."
else
    echo "0 players online, shutting down the server."
fi
