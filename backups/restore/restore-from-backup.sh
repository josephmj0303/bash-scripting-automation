#!/bin/bash
set -euo pipefail

# ==============================
# CONFIGURATION
# ==============================
REMOTE_USER=root
SSH_KEY=/root/.ssh/backup_key
LOG_FILE=/var/log/restore.log

# ==============================
# USAGE CHECK
# ==============================
if [[ $# -lt 4 ]]; then
  echo "Usage:"
  echo "  $0 <source_host> <backup_path> <backup_date> <restore_target>"
  echo
  echo "Example:"
  echo "  $0 93.127.198.153 /backups/debian 2025-12-20 /restore-test"
  exit 1
fi

SOURCE_HOST=$1
BACKUP_BASE=$2
BACKUP_DATE=$3
RESTORE_TARGET=$4

BACKUP_PATH="$BACKUP_BASE/$BACKUP_DATE"

echo "[$(date)] Restore started from $SOURCE_HOST:$BACKUP_PATH" >> $LOG_FILE

# ==============================
# VALIDATION
# ==============================
ssh -i $SSH_KEY $REMOTE_USER@$SOURCE_HOST "test -d $BACKUP_PATH" || {
  echo "Backup directory does not exist: $BACKUP_PATH"
  exit 1
}

mkdir -p "$RESTORE_TARGET"

# ==============================
# RESTORE DATA
# ==============================
rsync -az -e "ssh -i $SSH_KEY" \
  $REMOTE_USER@$SOURCE_HOST:$BACKUP_PATH/ \
  $RESTORE_TARGET/ >> $LOG_FILE 2>&1

echo "[$(date)] Restore completed successfully to $RESTORE_TARGET" >> $LOG_FILE
