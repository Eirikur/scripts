#!/bin/bash

file="$1"
file="${file#.}"
# unique="$(date +%s.%N)" # Unix date (epoch) in seconds, period, nanoseconds.
# unique="$(date +%s)" # Unix date (epoch) in seconds, period, nanoseconds.
suffix=".tar"
file="$file$suffix"
echo "Backing up $1"
# Bash requires distinction of the external program.
/usr/bin/time -f "%E" tar -cf $file $1 && du -h $file && ~/scripts/push-root.sh $file && rm $file

 
