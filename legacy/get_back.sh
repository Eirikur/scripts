#!/bin/bash
server=monolith
user=eh
server_root=/media

local_dir=`pwd`

# My standard options to rsync from mysync.sh
# --update means skip files that are newer on destinaton.
rsync $1 -a --human-readable --partial --recursive --progress --timeout=30 \
 --one-file-system --times --exclude='*.iso' --update  $2


