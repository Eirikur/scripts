#!/bin/bash
# Push a file to the remote version of working directory.  Strip home off.
# 9 May 2018, Patricia's birthday. Quoted $1 to "$1"
# 6 Aug 2019, added -z to enable compression
echo "Sending $1"
# time rsync --times --update --stats --archive --partial --partial-dir=~/.rsync-partial
/usr/bin/time -f%E rsync --times --update --archive --partial --partial-dir=~/.rsync-partial \
     --compress --compress-level=9 \
     --links --info=progress2 --human-readable "$1" \
     eirikur@argon1.local:"${PWD##/home/}/"
