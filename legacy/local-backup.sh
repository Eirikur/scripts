#!/bin/bash

if [[ "$2" == *:* ]]; then # If there is a colon in the destination/target...
    compress_option="-z"
    echo "Turning compresson on because the destination is over the network."
fi


/usr/bin/time -f%E  rsync "$1" -a --human-readable --partial --recursive --progress \
              --one-file-system --times --update "$compress_option"  --timeout=30 \
              --exclude='*.iso' \
              --exclude='*.img' \
              --exclude='*.img.*' \
              --exclude='datareporting' \
              --exclude='savedtelemetrypings' \
              --exclude='Trash' \
              "$2 $3 $4 $5 $6 $7 $8"
              

