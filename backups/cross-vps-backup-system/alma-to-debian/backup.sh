#!/bin/bash
set -euo pipefail

BACKUP_DATE=$(date +%F)
REMOTE_USER=root
REMOTE_HOST=82.112.227.194
REMOTE_DIR=/alma_backups/$BACKUP_DATE
SSH_KEY=/root/.ssh/backup_key
LOG_FILE=/var/log/backup-to-debian.log

echo "[$(date)] Alma → Debian backup started" >> $LOG_FILE

# Retention
ssh -i $SSH_KEY $REMOTE_USER@$REMOTE_HOST "
find /alma_backups/ -mindepth 1 -maxdepth 1 -type d \
! -newermt \"\$(date -d '7 days ago' +%F)\" \
-exec rm -rf {} \;
" >> $LOG_FILE 2>&1

# MSSQL backups
for DB in $(/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P '********' \
-Q "SET NOCOUNT ON; SELECT name FROM sys.databases WHERE name NOT IN ('master','model','msdb','tempdb');" -h -1); do
  /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P '********' \
  -Q "BACKUP DATABASE [$DB] TO DISK='/var/opt/mssql/backups/${DB}-$BACKUP_DATE.bak' WITH INIT;"
done

ssh -i $SSH_KEY $REMOTE_USER@$REMOTE_HOST "mkdir -p $REMOTE_DIR"

rsync -az -e "ssh -i $SSH_KEY" /var/www/ \
  $REMOTE_USER@$REMOTE_HOST:$REMOTE_DIR/www/

rsync -az -e "ssh -i $SSH_KEY" /var/opt/mssql/backups/ \
  $REMOTE_USER@$REMOTE_HOST:$REMOTE_DIR/sql/

rsync -az -e "ssh -i $SSH_KEY" /etc/ \
  $REMOTE_USER@$REMOTE_HOST:$REMOTE_DIR/etc/

rm -rf /var/opt/mssql/backups/*

echo "[$(date)] Alma → Debian backup completed" >> $LOG_FILE
