# Backup Streamer

Bash script to back up a web application and its database, then transfer the archive securely to a remote server via SSH/SFTP.

## Features
- Dumps a MySQL/MariaDB database
- Archives the web directory
- Combines database dump + web files into a single compressed `.tar.gz`
- Securely transfers the backup to a remote server using SSH keys
- Cleans up temporary files after upload

## Requirements
- Bash shell
- `mysqldump` (MySQL/MariaDB client tools)
- `tar`
- `ssh` client with key-based authentication set up

## Setup
1. Copy the script to your server.
2. Update the script variables:
   - **Database**
     - `DB_NAME` – database name
     - `DB_USER` – database username
     - `DB_PASS` – database password
   - **Web directory**
     - `WEB_DIR` – path to your website files
   - **Remote server**
     - `SFTP_USER` – remote SFTP username
     - `SFTP_HOST` – remote server IP/hostname
     - `SFTP_PATH` – destination directory on remote server
     - `SFTP_PORT` – SSH port (default: 22)
     - `SSH_KEY` – path to your private key

