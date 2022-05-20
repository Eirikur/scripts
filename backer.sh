#!/bin/bash


# New file 12 May 2022+
# 9 May 2018, Patricia's birthday. Quoted $1 to "$1"
# 6 Aug 2019, added -z to enable compression

# Pushing dir 'eh' into these locations.
destinations="onyx.local:/Fast 9185@usw-s009.rsync.net: z.local:/home "

path="$HOME"

for destination in $destinations  ; do
    # If our own hostname, ignore it.
    if [[ "$destination " == *"$(hostname)"* ]]; then
        # echo "Not copying to ourselves here at $destination."
        continue
    fi
    ~/scripts/just_push.sh "$path" "$destination"
done

# echo "Sent $1 $?"
exit $?
