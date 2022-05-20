#!/bin/bash

# My nice find of 4 SAS 8TB drives on eBay for 79.99 ea.

sudo zpool create -f sas \
     mirror \
     /dev/disk/by-id/scsi-35000c500ae573cb7 \
     /dev/disk/by-id/scsi-35000c500ae874ed7 \
     mirror \
     /dev/disk/by-id/scsi-35000c500ae899b7f \
     /dev/disk/by-id/
sudo zfs set compression=on sas
sudo zfs set atime=off sas


