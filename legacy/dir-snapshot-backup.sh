#!/bin/bash

file="$1"
file="${file#.}"
# unique="$(date +%s.%N)" # Unix date (epoch) in seconds, period, nanoseconds.
# unique="$(date +%s)" # Unix date (epoch) in seconds, period, nanoseconds.
suffix=".tar.gz"
file="$file$suffix"
echo "Backing up $1"
# Bash requires distinction of the external program.
/usr/bin/time -f "%E" tar -zcf $file $1 && echo "" && du -h --summarize $1 && du -h $file && ~/scripts/push.sh $file && rm $file

#!/bin/bash
# Push a file to the remote version of working directory.  Strip home off.
# 9 May 2018, Patricia's birthday. Quoted $1 to "$1"
# 6 Aug 2019, added -z to enable compression
echo "Sending $1"
# time rsync --times --update --stats --archive --partial --partial-dir=~/.rsync-partial
/usr/bin/time -f%E rsync --times --update --archive --partial --partial-dir=~/.rsync-partial \
     --compress --compress-level=9 \
     --links --info=progress2 --human-readable "$1" \
     9185@usw-s009.rsync.net:"${PWD##/home/}/"
