#!/bin/bash
set -euo pipefail

BACKUP_DATE=$(date +%F)
REMOTE_USER=root
REMOTE_HOST=93.127.198.153
REMOTE_DIR=/backups/debian/$BACKUP_DATE
SSH_KEY=/root/.ssh/backup_key
LOG_FILE=/var/log/backup-to-alma.log

echo "[$(date)] Debian → Alma backup started" >> $LOG_FILE

# Retention: keep exactly 7 days
ssh -i $SSH_KEY $REMOTE_USER@$REMOTE_HOST "
find /backups/debian/ -mindepth 1 -maxdepth 1 -type d \
! -newermt \"\$(date -d '7 days ago' +%F)\" \
-exec rm -rf {} \;
" >> $LOG_FILE 2>&1

# Prepare temp directory
mkdir -p /backup/db

# MySQL dump
mysqldump --all-databases | gzip > /backup/db/all-db-$BACKUP_DATE.sql.gz

# Sync data
rsync -az -e "ssh -i $SSH_KEY" \
  /var/lib/mysql/ /etc/ /home/ /backup/db/ \
  $REMOTE_USER@$REMOTE_HOST:$REMOTE_DIR/ >> $LOG_FILE 2>&1

# Cleanup
rm -rf /backup/db

echo "[$(date)] Debian → Alma backup completed" >> $LOG_FILE
