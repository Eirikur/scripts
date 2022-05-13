#!/bin/bash
# Push a file to the remote version of working directory.  Strip home off.
# 9 May 2018, Patricia's birthday. Quoted $1 to "$1"
# 6 Aug 2019, added -z to enable compression
# 7 Aug 2019, removed z to form put.sh
time rsync -a --stats --links --partial --partial-dir=~/.rsync-partial --progress --human-readable "$1" 9185@usw-s009.rsync.net:"${PWD##/home/}/"
