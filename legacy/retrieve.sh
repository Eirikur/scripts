#!/bin/bash
# Get everything back from rsync.net

for item in $(ssh 9185@usw-s009.rsync.net ls ); do
echo "$item"	
/usr/bin/time -f%E rsync -haAX --no-i-r --human-readable \
              --info=progress2 \
              9185@usw-s009.rsync.net:"$item" /internal/rsync.net/ \
              -e "ssh -T -c aes128-ctr -o Compression=no -x"
done


echo "Done."

