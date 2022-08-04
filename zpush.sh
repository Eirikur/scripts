#!/bin/bash

file="$1"
file="${file#.}"
file=${file%/} # Remove trailing / which might be there on directories.


# unique="$(date +%s.%N)" # Unix date (epoch) in seconds, period, nanoseconds.
suffix=".tar.zstd"
file="$file$suffix"
echo "Backing up $1"
start=$SECONDS
tar -cf - $1 | zstd -z --rsyncable >$file && echo "" && du -h --summarize $1 && du -h $file && ~/scripts/push.sh $file && rm $file
elapsed=$(( $SECONDS - start ))
elapsed_string=$(date -d@"$elapsed" -u +%-M:%S)
echo "$elapsed_string"
