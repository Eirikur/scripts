#!/bin/bash
echo "Deleting excluded files during copy!"
/usr/bin/time -f%E rsync -haAX --inplace --update \
              --info=progress2 -haAX --rsh="ssh -c arcfour" \
              --delete-during --delete-excluded --ignore-errors \
              --exclude='*.img' --exclude='Trash' \
              --exclude=cache --exclude=cache2 --exclude='.cache' \
              --exclude='saved-telemetry-pings' \
              # -e "ssh -T -c arcfour,aes128-ctr -o Compression=no -x" \
              #"$1" "$2" "$3" "$4"
              $1 $2 # "$3" "$4"




