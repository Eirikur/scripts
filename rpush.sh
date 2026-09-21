#!/bin/bash

offsite_user='de4686'
offsite_host='de4686.rsync.net'
offsite="$offsite_user@$offsite_host:"

in=$(realpath "$1")
echo "$offsite"
# /usr/bin/time -f%E rsync --no-i-r --times --update --archive --human-readable --info=progress2 "$in" \
#       9185@usw-s009.rsync.net:
/usr/bin/time -f%E rsync --no-i-r --times --update --archive --human-readable --info=progress2 "$in" "$offsite"


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
# read -p "All good. Dismiss:" q
exit 0
