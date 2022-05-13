#!/bin/bash

/usr/bin/time -f%E rsync -a --update --exclude=Trash --exclude=cache --exclude=cache2 --exclude='.cache' --exclude=saved-telemetry-pings --delete --delete-excluded --info=progress2 eh@solo:/home/eh /media/eh/3TB/

rsync -a --update --stats /media/eh/3TB/eh /media/eh/B/
rsync -a --update --stats /media/eh/3TB/eh /media/eh/C/

