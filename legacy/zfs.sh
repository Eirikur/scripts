#!/bin/bash

atime=off
xattr=sa
compress=lz4
recordsize=1M

-o ashift=12 should always be specified during pool creation,
except with SSDs that have 8k sectors where ashift=13 is correct.




# HortnetTek Enterprise 4 SATA slot JBOD

# sudo zpool create hornet  \
#      mirror /dev/disk/by-id/wwn-0x5000c50086c4632f /dev/disk/by-id/wwn-0x50014ee2b9b203d4 \
#      mirror /dev/disk/by-id/wwn-0x50014ee264a9aa3f /dev/disk/by-id/wwn-0x500003982b88081d

# sudo zfs set compression=on hornet

