#!/bin/bash
# 21 Sept. 2021
device="$1"
bootfs="${device}1"
rootfs="${device}2"

echo "Will check partitions $bootfs, $rootfs."

echo 'Checking boot partition...'
# -b: readonly check of boot blocks, -a: autorepair
# -t: mark unreadable blocks as bad. 
/usr/bin/time -f "%E" sudo dosfsck -b -a -t "$bootfs"
echo "Checking root partition on $rootfs..."
# -p: repair automatically
/usr/bin/time -f "%E" sudo e2fsck -p "$rootfs"

umount "$bootfs"
umount "$rootfs"
echo "Done."
exit 0

