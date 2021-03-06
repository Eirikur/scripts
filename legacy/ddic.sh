#!/bin/bash
echo 'Overwriting free space with zeros...'
time dd if=/dev/zero of=$2/__ZEROS__

time sudo dd if=$1 of=$2 bs=4M iflag=fullblock oflag=direct,dsync status=progress; sync; echo "Complete and synced."
