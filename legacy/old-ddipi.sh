#!/bin/bash
# NOTE: this is specific to Raspberry Pi Raspbian drive images. P1 is VFAT /boot, P2 is ext4 / or rootfs

echo "Zeroing unused blocks in first partition..."
tempfilename="__ZEROS__"
mount_point=$(findmnt --noheadings "$11" | awk '{print $1}')
target="$mount_point/$tempfilename"
sudo dd if=/dev/zero bs=32M iflag=fullblock of=$target status=progress  2> /dev/null; sync && sudo rm $target >& /dev/null
echo ''

echo "Zeroing unused blocks in second partition..."
mount_point=$(findmnt --noheadings "$12" | awk '{print $1}')
# Remount read-only
sudo mount -o remount,ro $mount_point
sudo zerofree -v ""$12""; sync # Second partition, device is sdc, this is partition /dev/sdc2
echo ''

echo "Imaging $1 into $2.gz"
time sudo dd if=$1 bs=32M iflag=fullblock status=progress | gzip --fast > "$2.gz" ; sync; echo "Complete and synced."
