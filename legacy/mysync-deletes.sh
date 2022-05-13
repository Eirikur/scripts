#!/bin/bash
# My standard options to rsync
# --update means skip files that are newer on destinaton.
rsync $1 -a --human-readable --partial --recursive --progress --timeout=60 \
 --one-file-system --times --update  $2 \
 --exclude='*.iso' --exclude='*.org' --exclude='~/.local/share/Trash/*' \
--delete-during --delete-excluded


