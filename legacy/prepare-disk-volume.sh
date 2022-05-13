#!/bin/bash
# 26 Nov 2020 Covid Thanksgiving. No support for other than ext4 yet.
# set -x
echo "Will zero-out $1 unless aborted."
echo "Press <return> to continue."
read nothing

sudo umount "$11" 2>&1 | /dev/null
sudo umount "$12" 2>&1 | /dev/null
sudo umount "$13" 2>&1 | /dev/null
sudo umount "$14" 2>&1 | /dev/null
sudo umount "$15" 2>&1 | /dev/null

default_fs="ext4"
FS_TYPE="${2:-$default_fs}"

# Write to every writable block, forcing remapping of bad blocks if handled in the firmware.
# echo "Zeroing $1 ..."
#/usr/bin/time -f%E sudo dd if=/dev/zero of="$1" bs=8M status=progress
# sync

# For mounting and fsck
# timestamp=$(date +%Y%m%d%H%M%S%N) # Include nanoseconds to prevent collisions.

# Create a partition map of type GPT for the most modern features.

echo "Creating GPT partion map..."
sudo parted "$1" --script -- mklabel gpt
sudo partprobe --summary "$1"
echo "Creating single $FS_TYPE partion..."
sudo parted "$1" --script -- mkpart primary $FS_TYPE 0% 100%
echo "Probing for the new partition..."
sudo partprobe --summary "$1"
echo ""
echo "Reading the partition table..."
sudo blockdev --rereadpt -v "$1"
echo ""
echo "Scanning for bad blocks and creating file system..."
sudo mke2fs "$11" -t ext4 -b 4096 -cc -FF -O dir_index -O extent # Hardcoded partition 1
echo "Reading the partition table..."
sudo blockdev --rereadpt -v "$1"

# check, force check even if clean, p=auto repair, v=chatter on stdout, y=answer yes to -p
# sudo e2fsck -cfpv "$11" # Hardcoded to partition 1.
echo "Done."


