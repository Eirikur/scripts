#!/bin/bash
# Pull a file from the remote version of working directory.
/usr/bin/time -f%E rsync -haAX --no-i-r --human-readable \
              --info=progress2 \
              eh@z.local:"$1" . \
              -e "ssh -T -c aes128-ctr -o Compression=no -x"

echo "Pull of $1 complete."
