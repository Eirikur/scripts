#!/bin/bash

# 27 July 2018: First account at Rsync.net.

# Steal this idea:
#(for ((i=0;i<100;i+=4)) ; do echo $i ; sleep 1; done) | zenity –progress –auto-close
# So:
# (for ((i=0;i<100;i+=4)) ; do read line; echo "#$line\n$i" ; done) | zenity –progress –auto-close




notify-send "Backup starting"
# Unmount Nemo/Nautilus gvfs mounts to prevent ugliness
gio mount --unmount-scheme=sftp




echo "Backup to rsync.net starting...."
notify-send "Backup to rsync.net starting...."

~/scripts/mysync.sh /home/eh 9185@usw-s009.rsync.net:
    # while read line; do echo "#$line"; done | zenity --width 1000 --progress --pulsate --auto-close --title "rsync.net"

if (($?)); then  # We failed.
    Q=$?
    echo "Backup to rsync.net failed: $Q"
    # notify-send --urgency=critical "Backup to rsync.net failed!"
    zenity --error --text "Backup to rsync.net failed: $Q"
    echo ""
    read -p "Error! Dismiss:" q

    exit 1

fi
echo "Backup to rsync.net succeeded."
notify-send "Backup to rsync.net succeeded."
echo ""
read -p "All good. Dismiss:" q




# echo "Backup to Skeleton starting...."
# notify-send "Backup to Skeleton starting...."

# ~/scripts/mysync.sh /home/eh eh@skeleton: # | \
#     # while read line; do echo "#$line"; done | zenity --width 1000 --progress --pulsate --auto-close --title "Skeleton"

# if (($?)); then  # We failed.
#     echo "Backup to Skeleton failed!"
#     # notify-send --urgency=critical "Backup to Skeleton failed!"
#     zenity --error --text "Backup to Skeleton failed!"
#     exit 1
# fi
# echo "Backup to Skeleton succeeded."
# notify-send "Backup to Skeleton succeeded."
