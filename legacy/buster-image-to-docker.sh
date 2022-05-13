#!/bin/bash
sudo losetup -P /dev/loop0 $1
sudo mount /dev/loop0p2 /mnt
sudo tar -C /mnt -cf - | docker import - buster-lite
sudo umount /mnt
sudo losetup -d /dev/loop0
