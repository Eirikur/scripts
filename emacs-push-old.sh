#!/bin/bash
# Push a file to the remote version of working directory.  Strip home off.
# 9 May 2018, Patricia's birthday. Quoted $1 to "$1"
# 6 Aug 2019, added -z to enable compression
# echo "Sending $1"
# time rsync --times --update --stats --archive --partial --partial-dir=~/.rsync-partial
full_file_path="$(realpath $1)" # As Emacs provides it.
full_file_path="$(echo "$full_file_path" | sed 's/ //g')" # Remove spaces, sigh.
target_dir='Emacs_Backups'
offsite_user='de4686'
offsite_host='de4686.rsync.net'
# de4686@de4686.rsync.net


# offsite="$offsite_user@$offsite_host:eh/"
offsite="$offsite_user@$offsite_host"


if rsync -a "$full_file_path" "$offsite"; then
    status="Saved on $offsite"
else
    status="Not saved to a remote."
fi

echo -n "$status"     


### Local save.

date_stamp=$(date +"%A-%b-%d-%Y+%H%M%S.%N")
file_name=$(basename "$1")
# Add time stamp
file_to_send="$full_file_path.$date_stamp"

# A local copy is the fastest recovery point.
mkdir -p "/home/eh/.emacs.d/$target_dir$(pwd)"
cp "$full_file_path" "/home/eh/.emacs.d/$target_dir/$file_to_send"





