#!/bin/bash

# Pass --delete --delete-during --delete-excluded to really clean up the remote.

echo "Sending..."
/usr/bin/time -f%E rsync --one-file-system  --archive --times --update --recursive -v\
     --partial --partial-dir=~/.rsync-partial \
     --compress --compress-level=9 \
     --links --info=progress2 --human-readable \
     --exclude='.cache' --exclude='.gvfs' --exclude='Trash' --exclude='.npm' --exclude='.wine' \
     /home/eh $1 eh@red.local:/media/eh/2tb2/
echo "Cloning to red.local:/media/eh/2tb2/$1 to 2tb3/ ..."
/usr/bin/time -f%E ssh eh@red.local "rsync --stats -a --times --update --info=progress2 /media/eh/2tb2/eh /media/eh/2tb3/"
