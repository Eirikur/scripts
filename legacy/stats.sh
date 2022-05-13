#!/bin/bash
# What's different between my home directory and my offsite backup?

/usr/bin/time -f%E rsync "/home/eh" '9185@usw-s009.rsync.net' --dry-run --stats \
                          -haAX --no-i-r --noatime --update --archive \
                          --info=progress2 --human-readable \
                          --exclude=cache --exclude='.cache' --exclude=Trash --exclude=saved-telemetry-pings \
                          -e "ssh -T -c aes128-ctr -o Compression=no -x"


