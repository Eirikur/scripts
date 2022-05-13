#!/bin/bash
file="$1"
file="${file#.}"
suffix=".tar.gz"
file="$file$suffix"
shopt -s expand_aliases
alias timeit='/usr/bin/time -f "%E"'

echo ""
echo "Archiving $1 into $file..."

/usr/bin/time -f "%E" tar -c $1 | gzip --rsyncable > $file

echo "$(du -h $file)Archived successfully."

rsync --progress --times --update --archive --partial --partial-dir=~/.rsync-partial \
     --links --info=progress2 --human-readable "$file" \
     9185@usw-s009.rsync.net:"${PWD##/home/}/"
exit $?

