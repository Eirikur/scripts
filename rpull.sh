#!/bin/bash

/usr/bin/time -f%E rsync --no-i-r --times --update --archive --human-readable --info=progress2  9185@usw-s009.rsync.net:"$1" .


if (($?)); then  # We failed.
    Q=$?
    echo "rpull of $1 to $PWD failed: $Q"
    exit 1
fi

echo "rpull of $1 to $PWD succeeded."
exit 0
