#!/bin/bash
set -
cd /home/backups
now=$(date)
timestamp=$(date +"%d-%B-%Y-%k-%M-%Z")
filename="EH-Backup-$timestamp.tar"
started="Starting Tar Backup at $now"
echo $started
show_time=30000
notify-send -t $show_time 'Starting Backup' "$started"
echo $filename
# 31 May 2014: add --one-file-system
# 09 Sept 2014 add --excludes of Wuala, *.tar add --ignore-failed-read
time tar --record-size=8192 -cf $filename /home/eh --one-file-system --exclude=WualaDrive --exclude=.wuala --exclude=Trash --exclude='*.tar' --ignore-failed-read
#time sudo XZ_OPT=-9 tar --record-size=8192 -cvJf eh.tar /home/eh --one-file-system --exclude=WualaDrive --exclude=.wuala --exclude=*.tar


if (( $? )); then
    # Failure
    notify-send "Backup: tar failed."
    echo "tar failure"
    exit
else # Success
    notify-send "Backup: tar succeeded"
    echo "Tar succeeded"
fi


# rsync --timeout=300 --partial -z /home/backups/eh.tar 192.168.1.200:
# rsync --timeout=300 --partial -z /home/backups/eh.tar eirkurh@eirikur.net:
# #rsync  -v -v --timeout=300 --progress --partial  /home/eh.tar eirikurh@eirikur.net:

# if (( $? )); then
#     # Failure
#     notify-send "Backup: rsync failed."
#     echo "rsync failure"
#     exit
# else # Success
#     notify-send "Backup: rsync succeeded"
#     echo "rsync success"
# fi

# echo "Tar Backup Complete."
# notify-send "Tar Backup Complete"

cd -
