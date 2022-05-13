#!/bin/bash
# Push a file to the remote version of working directory.  Strip home off.
# 9 May 2018, Patricia's birthday. Quoted $1 to "$1"j
# 6 Aug 2019, added -z to enable compression
#echo "Sending $1"
# time rsync --times --update --stats --archive --partial --partial-dir=~/.rsync-partial
# set -x
full_file_path="$1" # As Emacs provides it.
target_dir='Emacs_Backups'

destinations="silver.local$target_dir " # This is not in service yet.

date_stamp=$(date +"%A-%b-%d-%Y+%H%M%S.%N")
file_name=$(basename "$1")
# Add time stamp
file_to_send="$full_file_path.$date_stamp"

########################## Tramp mode for remote files.
if [[ "$full_file_path" == *":"* ]]; then
  echo "File is remote."
  host=$(echo "$full_file_path" | cut -d: -f2 )
  path=$(echo "$full_file_path" | cut -d: -f3)
  access="$host:$path"
  echo ">>>>>>>>>>>>>>>>>>>>>> $access"
fi
# cp "$full_file_path" "$file_to_send" # Create unique name.
if timeout 1 gethostip silver.local >/dev/null; then
    if ! rsync --timeout=5 -a --relative --implied-dirs ""$full_file_path""  "eh@silver.local:$target_dir"; then        silvermsg="Silver: FAILED"
    else
        silvermsg="Silver: Okay"
    fi
else
    silvermsg="Silver: not reachable."
fi




if rsync --timeout=5 --relative --implied-dirs "$full_file_path" \
         "9185@usw-s009.rsync.net:/data1/home/9185/$target_dir/"
then
    rsyncmsg="rsync.net: Okay"
else
    rsyncmsg="rsync.net: FAILED!"
fi

# Tell Emacs what happened.
echo -n "$rsyncmsg, $silvermsg"
