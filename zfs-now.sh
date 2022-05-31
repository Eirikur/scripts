#!/bin/bash

name="External"

sudo zpool create -o ashift=12 -O atime=off -O relatime=on \
     -O compression=lz4 -O xattr=sa \
     -f $name \
     mirror \
     /dev/disk/by-id/ata-HGST_HUS724020ALE640_PK2131P6GB9M9P \
     /dev/disk/by-id/ata-HGST_HUS724020ALE640_PK2131P6GD14VP \
     mirror \
     /dev/disk/by-id/ata-HGST_HUS724020ALE640_PK2131P6GD1M2P \
     /dev/disk/by-id/ata-HGST_HUS724020ALE640_PK2131P6GD6UNP \
     mirror \
     /dev/disk/by-id/ata-Hitachi_HUA722020ALA330_JK11A5B8K0BUKX \
     /dev/disk/by-id/ata-Hitachi_HUA722020ALA330_JK11A5B8K0UEDX \
     mirror \
     /dev/disk/by-id/ata-Hitachi_HUA722020ALA330_JK11A5B8K2J6EX \
     /dev/disk/by-id/ata-Hitachi_HUA722020ALA330_JK11A5B8K2J73X


     
     




