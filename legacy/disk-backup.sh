#!/bin/bash
# New backup script for disk to disk directory copies, 28 June 2018
rsync -v $1 $2 --perms --executability --update --xattrs --owner --group --times --archive --human-readable --partial --recursive --timeout=30 --one-file-system --exclude='*.iso' --exclude='.thumbnails' --exclude='.cache' --exclude='cache' --exclude='Cache' 
