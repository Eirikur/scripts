#!/bin/bash
card="$1"
tmp='/media/eh/Internal Tank/pi-card.img'

umount -v "$card1 $card2 $card3 $card4 $card5 $card6" 


/usr/bin/time -f%E sudo dd if="$card" of="$tmp" bs=8M iflag=fullblock status=progress; sync; echo "Complete and synced."

# r = advanced fs repair if needed. a = multiple core compression Z = compress output image with xz
/usr/bin/time -f%E ~/scripts/pishrink.sh -r -a -Z "$tmp"

rm "$tmp"


