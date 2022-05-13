#!/bin/bash
# Push a file to the remote version of working directory.  Strip home off.
# 9 May 2018, Patricia's birthday. Quoted $1 to "$1"
# 6 Aug 2019, added -z to enable compression
time rsync --stats -a --partial --partial-dir=~/.rsync-partial --compress --compress-level=9      --links --progress --human-readable "$1"      9185@usw-s009.rsync.net:"${PWD##/home/}/" --exclude=global-messages-db.sqlite --delete --delete-excluded
