#!/bin/bash

# First load into first syba5 disk box.
/dev/by-id/usb-ST4000VN_000-1H4168_DD2021050500087-0:0
/dev/by-id/usb-WDC_WD40_EFRX-68WT0N0_DD2021050500087-0:1
/dev/by-id/usb-ST4000DM_000-1F2168_DD2021050500087-0:2
/dev/by-id/usb-WDC_WD40_EFRX-68WT0N0_DD2021050500087-0:3



# for drive in usb-ST4000VN_000-1H4168_DD2021050500087-0:0 usb-WDC_WD40_EFRX-68WT0N0_DD2021050500087-0:1 usb-ST4000DM_000-1F2168_DD2021050500087-0:2 usb-WDC_WD40_EFRX-68WT0N0_DD2021050500087-0:3; do
#     cleaned=$(echo "$drive" | tr '/:' '_-')
#     byid="/dev/disk/by-id/$drive"
#     echo "$byid"
#     echo "$cleaned"
#     /usr/bin/time -f%E sudo badblocks -b 1024 -c 1024 -wsv -t random "$byid" -o "badblocks-$cleaned.txt"
#     echo "Done."
#     echo ""
# done


sudo zpool create syba -f \
     mirror /dev/by-id/usb-ST4000VN_000-1H4168_DD2021050500087-0:0 \
            /dev/by-id/usb-WDC_WD40_EFRX-68WT0N0_DD2021050500087-0:1 \
     mirror /dev/by-id/usb-ST4000DM_000-1F2168_DD2021050500087-0:2 \
            /dev/by-id/usb-WDC_WD40_EFRX-68WT0N0_DD2021050500087-0:3


     
     
     # mirror /dev/by-id/usb-External_USB3.0_DISK01_20170331000C3-0:1 \
     #        /dev/by-id/usb-External_USB3.0_DISK03_20170331000C3-0:2 \
     # mirror /dev/by-id/usb-External_USB3.0_DISK04_20170331000C3-0:3 \
     #        /dev/by-id/usb-External_USB3.0_DISK04_20170331000C3-0:4



sudo zfs set compression=on syba
# sudo zpool add backup log /dev/by-id/usb-External_USB3.0_DISK01_20170331000C3-0:0




