#!/bin/bash
# 11 Jan 2022 after big backup loss before HD job.

file="$1"
du --summarize -h "$file"
file="${file#.}" # Somehow strips a leading period.
file=$(echo "$file" | sed 's:/*$::') # Strip trailing slash.
file="$file.tgz"

/usr/bin/time -f%E tar -cf - "$1" | pv -s $(du -sb "$1" | awk '{print $1}')  | gzip --rsyncable > "$file"
du --summarize -h "$file"
echo ""
