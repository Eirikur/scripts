#!/bin/bash

/usr/bin/time -f%E rsync -a '9185@usw-s009.rsync.net:*' /internal




# /usr/bin/time -f%E rsync '9185@usw-s009.rsync.net:*' /internal \ # Grab it all to a local holding tank.
#               -haAX --no-i-r --noatime --update --archive \
#               --info=progress2 --human-readable \
#               --exclude=cache --exclude='.cache' --exclude=Trash --exclude=saved-telemetry-pings \
#               -e "ssh -T -c aes128-ctr -o Compression=no -x"

