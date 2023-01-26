#!/bin/bash
# Push a file to the remote version of working directory.  Strip home off.
# 9 May 2018, Patricia's birthday. Quoted $1 to "$1"j
# 6 Aug 2019, added -z to enable compression
# echo "Sending $1"
# time rsync --times --update --stats --archive --partial --partial-dir=~/.rsync-partial
full_file_path="$(realpath $1)" # As Emacs provides it.
full_file_path="$(echo "$full_file_path" | sed 's/ //g')" # Remove spaces, sigh.
target_dir='Emacs_Backups'
offsite_user='9185'
offsite_host='usw-s009.rsync.net'

destinations="onyx.local z.local $offsite_host"


# set -x
# set -e
# echo 'Start...'

date_stamp=$(date +"%A-%b-%d-%Y+%H%M%S.%N")
file_name=$(basename "$1")
# Add time stamp
file_to_send="$full_file_path.$date_stamp"

# A local copy is the fastest recovery point.
mkdir -p "/home/eh/.emacs.d/$target_dir$(pwd)"
cp "$full_file_path" "/home/eh/.emacs.d/$target_dir/$file_to_send"

# status='Saved to:'
saves=''
for destination in $destinations; do
    # if ~/scripts/push_it.sh "$full_file_path" "$destination" &> /dev/null; then
    if ~/scripts/push_it.sh "$full_file_path" "$destination" ; then
        saves="$saves $destination"
    fi
done


if [ -z "$saves" ]; then # is empty
    status="Not saved to a remote."
else
    status="Saved to:$saves" # Extra space at beginning of saves is handled.
fi


echo -n "$status"
