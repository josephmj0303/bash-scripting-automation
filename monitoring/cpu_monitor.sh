#!/bin/bash

THRESHOLD=80
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}')

if (( $(echo "$CPU_USAGE > $THRESHOLD" | bc -l) )); then
  echo "WARNING: High CPU usage - $CPU_USAGE%"
else
  echo "CPU usage normal - $CPU_USAGE%"
fi
