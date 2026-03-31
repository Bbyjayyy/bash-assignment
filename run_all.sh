#!/usr/bin/env bash
set -euo pipefail

mkdir -p logs
LOG_FILE="logs/app.log"

log() {
  echo "$(date '+%F %T') - $1" | tee -a "$LOG_FILE"
}

run_system_check() {
  bash scripts/system_check.sh
}

run_backup() {
  read -rp "Enter directory to back up: " dir
  bash scripts/backup.sh "$dir"
}

run_all() {
  bash scripts/user_info.sh || log "user_info failed"
  bash scripts/system_check.sh || log "system_check failed"
}

while true; do
  echo
  echo "1. Run all"
  echo "2. System check"
  echo "3. Backup"
  echo "4. Exit"
  read -rp "Choose an option: " choice

  case "$choice" in
    1) log "Running all"; run_all ;;
    2) log "Running system check"; run_system_check ;;
    3) log "Running backup"; run_backup ;;
    4) log "Exiting"; exit 0 ;;
    *) echo "Invalid option." ;;
  esac
done
