#!/bin/bash

# ashift=12
# atime=off
# xattr=sa
# compress=lz4
# recordsize=1M

# -o ashift=12 should always be specified during pool creation,
# except with SSDs that have 8k sectors where ashift=13 is correct.

sudo zpool create -f sas -o ashift=12   \
     mirror /dev/disk/by-id/scsi-35000c500ae573cb7 \
     /dev/disk/by-id/scsi-35000c500ae874ed7 \
     mirror /dev/disk/by-id/scsi-35000c500ae899b7f \
     /dev/disk/by-id/scsi-35000c500ae8a89e7
echo 'Created.'
sudo zfs set atime=off compress=lz4 xattr=sa recordsize=1m sas

