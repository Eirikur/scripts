#!/bin/bash

# || : colon is True, so this swallows errors
sudo umount $(findfs UUID=5a0757f3-c45d-4729-b7e8-8a6440cd9a73) || :
sudo umount $(findfs UUID=67fa8192-a96e-462a-9c0b-3e4d7df6e447) || :

set -e # Abort on error

# -p means tolerate existing and make parents if required.
sudo mkdir -p /media/eh/Backup-A
sudo mkdir -p /media/eh/Backup-B
sudo chown eh:eh /media/eh/Backup*
sync
# sleep 5
# sync

sudo mount UUID=5a0757f3-c45d-4729-b7e8-8a6440cd9a73 /media/eh/Backup-A
~/scripts/mysync.sh /home/eh /media/eh/Backup-A


sudo mount UUID=67fa8192-a96e-462a-9c0b-3e4d7df6e447 /media/eh/Backup-B
~/scripts/mysync.sh /home/eh /media/eh/Backup-B

sudo hdparm -K 1 -B 127 -S 12 $(findfs UUID=5a0757f3-c45d-4729-b7e8-8a6440cd9a73)
sudo hdparm -K 1 -B 127 -S 12 $(findfs UUID=67fa8192-a96e-462a-9c0b-3e4d7df6e447)

sudo umount UUID=5a0757f3-c45d-4729-b7e8-8a6440cd9a73
sudo umount UUID=67fa8192-a96e-462a-9c0b-3e4d7df6e447

sudo rmdir /media/eh/Backup-A
sudo rmdir /media/eh/Backup-B
