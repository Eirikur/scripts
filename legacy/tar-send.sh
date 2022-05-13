#!/bin/bash
# cd /home

# echo "Starting Tar Backup."
# notify-send "Starting Tar Backup"

# tar --record-size=8192 -cf /home/backups/eh.tar eh

# if (( $? )); then
#     # Failure
#     notify-send "Backup: tar failed."
#     echo "tar failure"
#     exit
# else # Success
#     notify-send "Backup: tar succeeded"
#     echo "tar success"
# fi


rsync --timeout=300 --partial -z /home/backups/eh.tar 192.168.1.200:
rsync --timeout=300 --partial -z /home/backups/eh.tar eirkurh@eirikur.net:
#rsync  -v -v --timeout=300 --progress --partial  /home/eh.tar eirikurh@eirikur.net:

if (( $? )); then
    # Failure
    notify-send "Backup: rsync failed."
    echo "rsync failure"
    exit
else # Success
    notify-send "Backup: rsync succeeded"
    echo "rsync success"
fi

echo "Tar Backup Complete."
notify-send "Tar Backup Complete"

cd -
