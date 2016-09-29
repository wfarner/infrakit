#!/usr/bin/env bash

set -o pipefail
set -o nounset

while true
do
  for host in 192.168.1.200 192.168.1.201 192.168.1.202
  do
    stat=$(echo stat | nc -G 1 -w 1 $host 2181)
    if [[ $? -ne 0 ]]
    then
      stat='(down)'
    else
      stat=$(echo "$stat" | grep Mode)
    fi

    echo "$host $stat"
  done
  echo
  sleep 2
done
