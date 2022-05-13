#!/bin/bash

# A stripe for inside silver, eventually to have a cache ssd
# single disk direct read 132MB/S write 150?
# In Gnome Disks 107, 87 - 101, 60
# 

sudo zpool create -f Internal \
     /dev/disk/by-id/wwn-0x5000c5007bda9aec \
     /dev/disk/by-id/wwn-0x5000cca39bce4682
