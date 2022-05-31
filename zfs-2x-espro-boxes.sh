#!/bin/bash


sudo zpool create -o ashift=12 -O atime=off -O relatime=on \
     -O compression=lz4 -O xattr=sa \
     -f External \
     mirror \
     /dev/disk/by-id/
     /dev/disk/by-id/scsi-35000c500ae874ed7 \
     mirror \
     /dev/disk/by-id/scsi-35000c500ae899b7f \
     /dev/disk/by-id/
sudo zfs set compress=zl4 External
sudo zfs set atime=off External



