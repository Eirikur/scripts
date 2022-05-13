#!/bin/bash

paths="/ /home/"
filename='__ZEROS__.dat'

for path in $paths;
do
    echo "Path: $path"
    full_path="$path$filename"
    /usr/bin/time -f%E sudo dd if=/dev/zero of=$full_path bs=8M iflag=fullblock status=progress
    echo "Syncing..."
    sync
    echo "Deleting: $full_path"
    sudo rm $full_path
    echo "Complete and synced."

    
done

# dd if=/dev/zero bs=16M iflag=fullblock | pv -s 100g -S | dd of="$1" bs=16M


# /usr/bin/time -f%E sudo dd if=$1 of=$2 bs=8M iflag=fullblock status=progress; echo "Syncing..."; sync; echo "Complete and synced."
