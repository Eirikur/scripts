#!/bin/bash
/usr/bin/time -f%E rsync  -haAX  --inplace --info=progress2 \
              --exclude='*.img' --exclude='Trash' \
              --exclude='Downloads' \
              --exclude='Instruments' \
              --exclude=cache --exclude=cache2 --exclude='.cache' \
              --exclude='*.iso' --exclude='*.tar' \
              --exclude='saved-telemetry-pings' \
               -e "ssh -T -c aes128-ctr -o Compression=no -x" \
              $1 $2 $3 $4




