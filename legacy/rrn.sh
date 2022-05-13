#!/bin/bash
# 11 Jan 2022 after big backup loss before HD job.
# 10 Feb 2022 added looping over list of arguments.
for path in "$@"
do
    echo "Backing up $path"
    file="$path"
    file="${file#.}" # Somehow strips a leading period.
    file=$(echo "$file" | sed 's:/*$::') # Strip trailing slash.
    archive="$file.tgz"

    size=$(du -sh "$path" | cut -f1)
    echo "$path  $size"
    /usr/bin/time -f%E tar -cf - "$path" | gzip --rsyncable > "$archive"
    size=$(du -h "$archive" | cut -f1)
    echo ""
    echo "Archive done. Size: $size"

    echo "Transfering..."
    /usr/bin/time -f%E rsync --no-i-r --compress --times --update \
                  --archive --human-readable --info=progress2 "$archive" \
                  9185@usw-s009.rsync.net:


    if (($?)); then  # We failed.
        Q=$?
        echo "Copy of $path to root directory at rsync.net failed: $Q"
        notify-send --urgency=critical "Copy of $path to root at rsync.net failed!"
        echo ""
        read -p "Error! Dismiss:" q
        exit 1
    fi

    echo "Copy of $archive to root directory at rsync.net succeeded."
    notify-send "Copy of $archive to rsync.net succeeded."
    echo "Preserving file $archive."
    # rm "$archive" -v
    echo ""
    read -p "All good. Dismiss:" q
    exit 0

done
