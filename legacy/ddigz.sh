#!/bin/bash
set -e
/usr/bin/time -f%E sudo dd if=$1 bs=32M iflag=fullblock status=progress | gzip > "$2"
echo "Syncing..."
sync
echo "Complete and synced."
