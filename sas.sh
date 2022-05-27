#!/bin/bash

# ashift=12
# atime=off
# xattr=sa
# compress=lz4
# recordsize=1M

# -o ashift=12 should always be specified during pool creation,
# except with SSDs that have 8k sectors where ashift=13 is correct.

sudo zpool create -f sas -o ashift=12   \
     mirror /dev/disk/by-id/ata-Hitachi_HUA722020ALA330_JK11A5B8K2J6EX \
     /dev/disk/by-id/ata-Hitachi_HUA722020ALA330_JK11A5B8K2J73X \
     mirror /dev/disk/by-id/ata-Hitachi_HUA722020ALA330_JK11A5B8K0BUKX \
     /dev/disk/by-id/ata-Hitachi_HUA722020ALA330_JK11A5B8K0UEDX
echo 'Created.'
sudo zfs set atime=off compress=lz4 xattr=sa recordsize=1m sas


