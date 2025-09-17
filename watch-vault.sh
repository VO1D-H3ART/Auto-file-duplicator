#!/usr/bin/env bash
set -euo pipefail

SRC="/srv/syncthing/ObsidianVault"
DEST="/srv/cloud/ObsidianVault"
LOG="/var/log/watch-vault.log"

mkdir -p "$DEST"
mkdir -p "$(dirname "$LOG")"

# Sync once at startup
rsync -aHAX --delete-delay \
  --exclude ".stfolder" \
  --exclude ".stversions/" \
  --exclude ".stignore" \
  --exclude ".syncthing.*" \
  --exclude ".sync-conflict-*" \
  "$SRC"/ "$DEST"/ \
  | sed "s/^/[$(date -Is)] /" | tee -a "$LOG"

# Watch for changes
inotifywait -mr -e create,modify,delete,move --format '%w%f' "$SRC" | {
  t=0
  while read -r file; do
    now=$(date +%s)
    if (( now - t < 2 )); then
      t=$now; continue
    fi
    t=$now
    sleep 2
    echo "[$(date -Is)] Change detected: $file" | tee -a "$LOG"
    rsync -aHAX --delete-delay \
      --exclude ".stfolder" \
      --exclude ".stversions/" \
      --exclude ".stignore" \
      --exclude ".syncthing.*" \
      --exclude ".sync-conflict-*" \
      "$SRC"/ "$DEST"/ \
      | sed "s/^/[$(date -Is)] /" | tee -a "$LOG"
    echo "[$(date -Is)] Sync complete" | tee -a "$LOG"
  done
}
