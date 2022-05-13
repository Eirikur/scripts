#!/bin/bash

# Steal this idea:
#(for ((i=0;i<100;i+=4)) ; do echo $i ; sleep 1; done) | zenity –progress –auto-close
# So:
# (for ((i=0;i<100;i+=4)) ; do read line; echo "#$line\n$i" ; done) | zenity –progress –auto-close

notify-send "Post of $1 starting"
# Unmount Nemo/Nautilus gvfs mounts to prevent ugliness
# gvfs-mount --unmount-scheme=sftp

# echo "Post of $1 to Skeleton starting...."
# notify-send "post of $1 to Skeleton starting...."

# rsync "$1" eh@skeleton: # | \
#     # while read line; do echo "#$line"; done | zenity --width 1000 --progress --pulsate --auto-close --title "Skeleton"

# if (($?)); then  # We failed.
#     echo "Post of $1 to Skeleton failed!"
#     # notify-send --urgency=critical "post of $1 to Skeleton failed!"
#     zenity --error --text "post of $1 to Skeleton failed!"
#     exit 1
# fi
# echo "Post of $1 to Skeleton succeeded."
# notify-send "post of $1 to Skeleton succeeded."



echo "Post of $1 to eirikur.net starting...."
 "post of $1 to eirikur.net starting...."

rsync "$1" eirikurh@eirikur.net:eirikur.net/ # | \
    # while read line; do echo "#$line"; done | zenity --width 1000 --progress --pulsate --auto-close --title "eirikur.net"

if (($?)); then  # We failed.
    echo "Post of $1 to eirikur.net failed!"
    # notify-send --urgency=critical "post of $1 to eirikur.net failed!"
    zenity --error --text "post of $1 to eirikur.net failed!"
    exit 1

fi
echo "Post of $1 to eirikur.net succeeded."
notify-send "post of $1 to eirikur.net succeeded."
