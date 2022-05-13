#!/bin/bash

sudo bcachefs format \
    --group=ssd /dev/sdb  \
    --group=hdd /dev/sdc  \
    --data_replicas=1 --metadata_replicas=2 \
    --foreground_target=ssd \
    --background_target=hdd \
    --promote_target=ssd
sudo mount -t bcachefs /dev/sdb:/dev/sdc: /mnt
