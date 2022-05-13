#!/bin/bash

/usr/bin/time -f%E rsync -a --update --info=progress2 \
              --exclude='Trash' \
              --exclude='.cache' --exclude=cache --exclude=cache2 \
              --exclude='saved-telemetry-pings' \
              $1 $2 $3 $4




