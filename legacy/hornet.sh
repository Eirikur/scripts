#!/bin/bash

# HortnetTek Enterprise 4 SATA slot JBOD
# Disks e,f,g,h as enumerated on silver

sudo zpool create hornet -f \
     mirror /dev/disk/by-id/wwn-0x5000c50086c4632f /dev/disk/by-id/wwn-0x50014ee2b9b203d4 \
     mirror /dev/disk/by-id/wwn-0x50014ee264a9aa3f /dev/disk/by-id/wwn-0x500003982b88081d

sudo zfs set compression=on hornet
