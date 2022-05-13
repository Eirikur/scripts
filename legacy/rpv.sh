#!/bin/bash
# 11 Jan 2022 after big backup loss before HD job.

file="$1"
file="${file#.}" # Somehow strips a leading period.
file=$(echo "$file" | sed 's:/*$::') # Strip trailing slash.

#!/bin/bash
# Push a file to the remote version of working directory.  Strip home off.
# 9 May 2018, Patricia's birthday. Quoted $1 to "$1"
# 6 Aug 2019, added -z to enable compression
# echo "Sending $1"
# time rsync --times --update --stats --archive --partial --partial-dir=~/.rsync-partial
#     --compress --compress-level=9 \
/usr/bin/time -f%E rsync --no-i-r --compress --times --update --archive --partial --partial-dir=~/.rsync-partial \
      --links --info=progress2 --human-readable --stats "$1" \
      --exclude=cache --exclude='.cache' --exclude=Trash --exclude=saved-telemetry-pings \
      "$2"

if (($?)); then  # We failed.
    Q=$?
    echo "Copy of $1 to $2 failed: $Q"
    notify-send --urgency=critical "Copy of $1 to $2 failed!"
    echo ""
    read -p "Error! Dismiss:" q
    exit 1

fi
echo "Copy of $1 to $2 succeeded."
notify-send "Copy of $1 to $2 succeeded."
echo ""
read -p "All good. Dismiss:" q
exit 0
