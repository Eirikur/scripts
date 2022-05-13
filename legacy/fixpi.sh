#!/bin/bash
# fixpi.sh 13Aug2019

drive=$1
echo "/dev/${drive}1"
umount "/dev/${drive}1"
umount "/dev/${drive}2"

# M: skip mounted volumes
sudo fsck -aM "/dev/${drive}1"
sudo fsck -aM "/dev/${drive}2"
