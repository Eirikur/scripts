#!/bin/bash

name="External"

sudo zpool create -o ashift=12 -O atime=off -O relatime=on \
     -O compression=lz4 -O xattr=sa \
     -f $name \
     mirror \
     /dev/disk/by-id/
     /dev/disk/by-id/
     mirror \
     /dev/disk/by-id/
     /dev/disk/by-id/




