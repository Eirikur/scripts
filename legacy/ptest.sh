#!/bin/bash
# Push a file to the remote version of working directory.  Strip home off.
# 9 May 2018, Patricia's birthday. Quoted $1 to "$1"
# 6 Aug 2019, added -z to enable compression
# echo "Sending $1"
# time rsync --times --update --stats --archive --partial --partial-dir=~/.rsync-partial
#     --compress --compress-level=9 \
rsync  --compress --times --update --archive --partial --partial-dir=~/.rsync-partial \
      --links --out-format='%n' --info=name --human-readable "$1" \
      --exclude=cache --exclude='.cache' --exclude=Trash --exclude=saved-telemetry-pings \
      9185@usw-s009.rsync.net:"${PWD##/home/}/"
# echo "Sent $1 $?"
exit $?
# /usr/bin/time -f%E rsync "$2" --compress --times --update --archive --partial --partial-dir=~/.rsync-partial \
#  --links --out-format='%n' --info=name --human-readable "$1" \
#  --exclude=cache --exclude='.cache' --exclude=Trash --exclude=saved-telemetry-pings \
#      9185@usw-s009.rsync.net:"${PWD##/home/}/"
# # echo "Sent $1 $?"
# exit $?
