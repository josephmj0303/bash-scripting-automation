#!/bin/bash

TMP_DIR="/tmp"
DAYS=7

find "$TMP_DIR" -type f -mtime +$DAYS -exec rm -f {} \;

echo "Temporary files older than $DAYS days removed"
