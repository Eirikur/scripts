#!/bin/bash
# 11 Jan 2022 after big backup loss before HD job.
# 10 Feb 2022 added looping over list of arguments.
for path in "$@"
do
    echo "Backing up $path"
    file="$path"
    file="${file#.}" # Somehow strips a leading period.
    file=$(echo "$file" | sed 's:/*$::') # Strip trailing slash.
    archive="$file.tar.zstd"

    size=$(du -sh "$path" | cut -f1)
    echo "$path  $size"
    /usr/bin/time -f%E tar -cf - "$path" | gzip --rsyncable > "$archive"
    size=$(du -h "$archive" | cut -f1)
    echo "Archive done. Size: $size"


    
    echo "Transfering to Silver..."
    /usr/bin/time -f%E rsync --no-i-r --times --update \
                  --archive --human-readable --info=progress2 "$archive" \
                  eh@silver.local:/hornet/Archives/


    if (($?)); then  # Transfer failed.
        Q=$?
        echo "Copy of $path to 3TB on Silver failed: $Q"
        notify-send --urgency=critical "Copy of $path to 3TB on Silver failed!"
        echo ""
        read -p "Error! Dismiss:"
        exit 1
    fi

    echo "Copy of $archive to 3TB on Silver succeeded."
    notify-send "Copy of $archive to 3TB on Silver succeeded."
    echo ""
    echo "All good."
    echo ""


    ####
    
    echo "Transfering to rsync.net..."
    /usr/bin/time -f%E rsync --no-i-r --times --update \
                  --archive --human-readable --info=progress2 "$archive" \
                  9185@usw-s009.rsync.net:


    if (($?)); then  # Transfer failed.
        Q=$?
        echo "Copy of $path to root directory at rsync.net failed: $Q"
        notify-send --urgency=critical "Copy of $path to root at rsync.net failed!"
        echo ""
        read -p "Error! Dismiss:"
        exit 1
    fi

    echo "Copy of $archive to root directory at rsync.net succeeded."
    notify-send "Copy of $archive to rsync.net succeeded."
    rm "$archive" -v
    echo ""
    echo "All good."
    
done
