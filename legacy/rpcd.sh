#!/bin/bash
echo "Deleting excluded files during copy!"
/usr/bin/time -f%E rsync -av --update --info=progress2 \
              --delete --delete-excluded \
              --exclude='*.img' --exclude='Trash' \
              --exclude=cache --exclude=cache2 --exclude='.cache' \
              --exclude='saved-telemetry-pings' \
              $1 $2 $3 $4




