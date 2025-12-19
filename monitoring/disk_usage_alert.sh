#!/bin/bash

THRESHOLD=75

df -h | grep '^/dev/' | while read fs size used avail use mount; do
  usage=${use%\%}

  if [[ $usage -ge $THRESHOLD ]]; then
    echo "ALERT: $fs mounted on $mount is ${usage}% full"
  fi
done
