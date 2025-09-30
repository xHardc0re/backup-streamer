#!/bin/bash

WEB_DIR="/var/www/vhosts/webdir"
DB_NAME="db_name"
DB_USER="db_user"
DB_PASS="db_passwd"

BACKUP_DIR="/temp/backup_dir"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
DB_FILE="db_${TIMESTAMP}.sql"
DB_DUMP="$BACKUP_DIR/${DB_FILE}.sql"
BACKUP_FILE="backup_${TIMESTAMP}.tar.gz"

SFTP_USER="sftp_user"
SFTP_HOST="123.123.123.123"
SFTP_PORT=22
SFTP_PATH="/sftp/path"
SSH_KEY="$HOME/.ssh/backup"

mkdir -p "$BACKUP_DIR"

mysqldump -u"$DB_USER" -p"$DB_PASS" "$DB_NAME" > "$DB_DUMP"

tar -czf - \
  --ignore-failed-read \
  -C "$WEB_DIR" \
  --exclude="system/storage/cache" \
  --exclude="system/storage/logs" \
  --exclude="system/storage/download" \
  --exclude="system/storage/modification" \
  --exclude="system/storage/session" \
  --exclude="system/storage/upload" \
  --exclude="image/cache" \
  . \
  -C "$BACKUP_DIR" "$(basename "$DB_DUMP")" \
  --transform "s|^$(basename "$DB_DUMP")$|db_${TIMESTAMP}.sql|" | \
ssh -i "$SSH_KEY" -p "$SFTP_PORT" "$SFTP_USER@$SFTP_HOST" \
  "cat > $SFTP_PATH/$BACKUP_FILE"

rm -f "$DB_DUMP"
