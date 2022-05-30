#!/bin/bash

# ashift=12
# atime=off
# xattr=sa
# compress=lz4
# recordsize=1M

# -o ashift=12 should always be specified during pool creation,
# except with SSDs that have 8k sectors where ashift=13 is correct.

name='External'

sudo zpool create -o ashift=12 -f External \
     mirror /dev/disk/by-id/ata-Hitachi_HUA722020ALA330_JK11A5B8K2J6EX \
     /dev/disk/by-id/ata-Hitachi_HUA722020ALA330_JK11A5B8K2J73X \
     mirror /dev/disk/by-id/ata-Hitachi_HUA722020ALA330_JK11A5B8K0BUKX \
     /dev/disk/by-id/ata-Hitachi_HUA722020ALA330_JK11A5B8K0UEDX \
     mirror /dev/disk/by-id/ata-HGST_HUS724020ALE640_PK2131P6GD1M2P \
     /dev/disk/by-id/ata-HGST_HUS724020ALE640_PK2131P6GD6UNP \
     mirror /dev/disk/by-id/ata-HGST_HUS724020ALE640_PK2131P6GD14VP \
     /dev/disk/by-id/ata-HGST_HUS724020ALE640_PK2131P6GB9M9P

echo 'Created.'
sudo zfs set atime=off compress=lz4 xattr=sa recordsize=1m $name
