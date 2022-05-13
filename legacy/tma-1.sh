#!/bin/bash



if /usr/bin/time -f%E rsync  -haAX  --inplace --info=progress2 \
              --exclude='*.img' --exclude='Trash' \
              --exclude='Downloads' \
              --exclude='Instruments' \
              --exclude=cache --exclude=cache2 --exclude='.cache' \
              --exclude='*.iso' --exclude='*.tar' \
              --exclude='saved-telemetry-pings' \
              /home/eh /media/eh/backup_files/ ; then
    echo 'Success'
else
    notify-send 'Home dir backup script failed.'
    echo 'Failed'
fi
    




