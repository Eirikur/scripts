#!/bin/bash
# Push a file to the remote version of working directory.  Strip home off.
# 9 May 2018, Patricia's birthday. Quoted $1 to "$1"j
# 6 Aug 2019, added -z to enable compression
# echo "Sending $1"
# time rsync --times --update --stats --archive --partial --partial-dir=~/.rsync-partial
full_file_path="$(realpath $1)" # As Emacs provides it.
target_dir='Emacs_Backups'
offsite_user='9185'
offsite_host='usw-s009.rsync.net'

destinations="onyx.local z.local $offsite_host"


date_stamp=$(date +"%A-%b-%d-%Y+%H%M%S.%N")
file_name=$(basename "$1")
# Add time stamp
file_to_send="$full_file_path.$date_stamp"

# A local copy is the fastest recovery point.
mkdir -p "/home/eh/.emacs.d/$target_dir$(pwd)"
cp "$full_file_path" "/home/eh/.emacs.d/$target_dir/$file_to_send"

status='Saved to:'
for destination in $destinations; do
    # if ~/scripts/push_it.sh "$full_file_path" "$destination" &> /dev/null; then
    if ~/scripts/push_it.sh "$full_file_path" "$destination" ; then
        status="$status  $destination"
        echo -n '' #"Good."
    else
        echo -n '' # echo "Not good!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
    fi

    #     status="$status $destination Bad."
    # fi
done
# Tell Emacs what happened.
echo -n "$status"
