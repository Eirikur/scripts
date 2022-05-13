#!/bin/bash
set -e
iflags='fullblock,noatime'
oflags='direct,noatime'
/usr/bin/time -f%E sudo dd if=$1 of=$2 bs=8M iflag="$iflags" oflag="$oflags" status=progress; \
    echo "Syncing..."; sync; echo "Complete and synced."

