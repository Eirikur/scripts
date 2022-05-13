#!/bin/bash
notify-send "Backup starting"
# Unmount Nemo/Nautilus gvfs mounts to prevent ugliness
gvfs-mount --unmount-scheme=sftp
time ./scripts/mysync.sh /home/eh eirikurh@eirikur.net
time ./scripts/mysync.sh /home/eh eh@skeleton

