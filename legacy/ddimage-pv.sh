#!/bin/bash

# unfinished.

time pv $1 --progress --eta --| dd of=$2 bs=4M iflag=fullblock oflag=direct status=progress; sync; echo "Complete and synced."
# time sudo dd if=$1 of=$2 bs=4M iflag=fullblock oflag=direct status=progress; sync; echo "Complete and synced."
