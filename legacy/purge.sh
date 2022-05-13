#!/bin/bash
# Push a file to the remote version of working directory.  Strip home off.
# 9 May 2018, Patricia's birthday. Quoted $1 to "$1"
# 6 Aug 2019, added -z to enable compression
echo "Sending $1"
time rsync --delete --delete-during --recursive --progress --human-readable "$1" \
     --existing --ignore-non-existing \
     9185@usw-s009.rsync.net:"${PWD##/home/}/"
