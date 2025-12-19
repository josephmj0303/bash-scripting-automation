#!/bin/bash

SRC="/home"
DEST="/backup/home"
DATE=$(date +%F)

mkdir -p "$DEST"

tar -czf "$DEST/home-backup-$DATE.tar.gz" "$SRC"

echo "Backup completed: $DEST/home-backup-$DATE.tar.gz"
