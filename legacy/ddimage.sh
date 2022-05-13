#!/bin/bash
set -e
/usr/bin/time -f%E sudo dd if=$1 of=$2 bs=8M iflag=fullblock status=progress; echo "Syncing..."; sync; echo "Complete and synced."
