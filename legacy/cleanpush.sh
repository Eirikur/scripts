#!/bin/bash
# Push a file to the remote version of working directory.  Strip home off.
# 9 May 2018, Patricia's birthday. Quoted $1 to "$1"
# 6 Aug 2019, added -z to enable compression
# echo "Sending $1"
# time rsync --times --update --stats --archive --partial --partial-dir=~/.rsync-partial
echo "cleanpush.sh is going to delete all files not present locally in $1 on the remote!"
read ignored
/usr/bin/time -f%E rsync --progress --times --update --archive --partial --partial-dir=~/.rsync-partial \
 --compress --compress-level=9 \
 --delete --delete-during \
     --links --info=progress2 --human-readable "$1" \
     9185@usw-s009.rsync.net:"${PWD##/home/}/"
# echo "Sent $1 $?"
exit $?
