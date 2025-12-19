#!/bin/bash

LOG_DIR="/var/log/myapp"
ARCHIVE_DIR="/var/log/myapp/archive"
DATE=$(date +%F)

mkdir -p "$ARCHIVE_DIR"

for log in $LOG_DIR/*.log; do
  gzip -c "$log" > "$ARCHIVE_DIR/$(basename $log)-$DATE.gz"
  truncate -s 0 "$log"
done

echo "Log rotation completed"
