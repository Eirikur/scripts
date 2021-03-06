#!/bin/bash
# Pull a file from the remote root.
time rsync -a --stats --progress --human-readable \
      --compress --compress-level=9 \
      --partial --partial-dir=~/.rsync-partial \
      9185@usw-s009.rsync.net:"$1" .
