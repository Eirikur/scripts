#!/bin/bash
rsync /home/eh --stats bamboo: --perms --executability --update --xattrs --owner --group --cvs-exclude --times --archive --human-readable --partial --recursive --timeout=60 --one-file-system --out-format=%n --delete-during  > ~/bamboo.log
touch ~/TIMESTAMP
