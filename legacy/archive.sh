#!/bin/bash
local_dir='/home/eh/Archives/'
remote_dir='Archives/'
source="$1"
source=${source%/} # Remove trailing / which might be there on directories.
filename=${source#.} # Remove leading . if present.
archive="$local_dir$filename.tar.zstd"
indent="  "
okay="\U1f197"
not_okay="\U1f534"

# set -x
size=$(du -sh "$source" | cut -f1)
echo "$source $size"
start=$SECONDS
tar -cf - "$source" | pv | zstd -z --rsyncable -f  > "$archive"
elapsed=$(( $SECONDS - start ))
elapsed_string=$(date -d@"$elapsed" -u +%-M:%S)

size=$(du -h "$archive" | cut -f1)
echo -e "$elapsed_string $filename.tar.zstd $size $okay"

~/scripts/just_push.sh "$local_dir$filename.tar.zstd" "onyx.local:/Fast/"
~/scripts/just_push.sh "$local_dir$filename.tar.zstd" "onyx.local:/syba/Archives/"
~/scripts/just_push.sh "$local_dir$filename.tar.zstd" "9185@usw-s009.rsync.net:$remote_dir"
