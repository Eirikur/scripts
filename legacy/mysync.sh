#!/bin/bash
# My standard options to rsync
# --update means skip files that are newer on destinaton.
# 07 Aug 2018: add $3 to allow passing --delete to rsync.

/usr/bin/time -f%E rsync $1  --no-i-r --human-readable --times  \
      --recursive  --timeout=60 --archive --one-file-system \
      --partial --partial-dir=~/.rsync-partial --compress --compress-level=9 \
      --info=progress2 --stats \
      --exclude='*.iso' --exclude='*.tar' \
      --exclude='.cache' --exclude='cache' --exclude='cache2' \
      --exclude='saved-telemetry-pings' \
      --exclude='*.img' --exclude='Trash' \
      --exclude='Downloads' \
      --exclude='Instruments' \
      --update  $2 $3
sync

