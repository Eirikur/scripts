#!/bin/bash



sudo zpool create backup -f \
     mirror /dev/by-id/usb-External_USB3.0_DISK01_20170331000C3-0:1 \
            /dev/by-id/usb-External_USB3.0_DISK03_20170331000C3-0:2 \
     mirror /dev/by-id/usb-External_USB3.0_DISK04_20170331000C3-0:3 \
            /dev/by-id/usb-External_USB3.0_DISK04_20170331000C3-0:4



sudo zfs set compression=on backup
sudo zpool add backup log /dev/by-id/usb-External_USB3.0_DISK01_20170331000C3-0:0




