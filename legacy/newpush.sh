#!/bin/bash
# Push a file to the remote version of working directory.  Strip home off.
# 9 May 2018, Patricia's birthday. Quoted $1 to "$1"
# 6 Aug 2019, added -z to enable compression
# echo "Sending $1"
# time rsync --times --update --stats --archive --partial --partial-dir=~/.rsync-partial
declare -a destinations # Uppercase = associative, lowercase simple array.
destination_directory="${PWD##/home/}/" # 
local_target="/media/Internal_Tank/"
cloud_target="9185@usw-s009.rsync.net:"
lan_target=""

for target in {'local_target cloud_target lan_target'}; do
    echo $target
    destinations+="$target$destination_directory"
    done

echo $destinations

# /usr/bin/time -f%E rsync --progress --times --update --archive --partial --partial-dir=~/.rsync-partial \
#      --compress --compress-level=9 \
#      --links --info=progress2 --human-readable "$1" \
#      9185@usw-s009.rsync.net:"${PWD##/home/}/"
# # echo "Sent $1 $?"
# exit $?
