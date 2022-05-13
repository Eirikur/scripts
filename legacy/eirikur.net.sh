#!/bin/bash
rsync /home/eh --stats eirikurh@eirikur.net: --perms --executability --update --xattrs --owner --group --cvs-exclude --times --archive --human-readable --partial --recursive --timeout=60 --one-file-system --out-format=%n --delete-during  --exclude=*.iso  --exclude=information.org > ~/eirikur.net.log
touch ~/TIMESTAMP
