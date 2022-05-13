#!/bin/bash
# My standard options to rsync
# --update means skip files that are newer on destinaton.
# 07 Aug 2018: add $3 to allow passing --delete to rsync.

/usr/bin/time -f%E rsync "$1" -a -v --human-readable --times --progress --recursive  --timeout=60 --stats \
      --partial --partial-dir=~/.rsync-partial --compress --compress-level=9 \
      --archive --one-file-system --times  \
      --exclude='*.iso' --exclude='*.tar' --exclude='.cache' --exclude='.gvfs' \
      --exclude='*.img' --exclude='Trash' \
      --exclude='Downloads' \
      --exclude='Instruments' \
      --update  "$2" "$3"
sync
