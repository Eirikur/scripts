#!/bin/bash

/usr/bin/time -f%E rsync --no-i-r --times --update --archive --human-readable --info=progress2 "$1" \
      9185@usw-s009.rsync.net:


if (($?)); then  # We failed.
    Q=$?
    echo "Copy of $1 to root directory at rsync.net failed: $Q"
    notify-send --urgency=critical "Copy of $1 to root at rsync.net failed!"
    echo ""
    read -p "Error! Dismiss:" q
    exit 1

fi
echo "Copy of $1 to root directory at rsync.net succeeded."
notify-send "Copy of $1 to rsync.net succeeded."
echo ""
read -p "All good. Dismiss:" q
exit 0
