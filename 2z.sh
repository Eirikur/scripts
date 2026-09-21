#!/bin/bash
# Time-stamp: <2025-08-14 23:16:37 eh>

remote="z800.local:"
remote_path="${PWD##"$HOME/"}/" # Path from my root to here with trailing /.
echo "$remote_path"
echo "$1"

target="$remote$remote_path"


# --skip-specials
rclone sync --skip-links  "$1" ":sftp:$target" --stats 2s  |&  grep -v "Can't save config"














# estinations="tma-1.local onyx.local: onyx.local:/syba/eh/ z.local: $offsite"
# # destinations="tma-1.local onyx.local: $offsite"
# destinations="z800.local"
# destination_directory="${PWD##/home/}/" # eh/path/path
# # destination_directory=""
# indent="  "
# okay="\U1f197"
# checkmark="\U2705"
# okay="$checkmark" 
# not_okay="\U1f534"
# arrow="\u2B95"
# home="\U1f3e1" # house with garden to mean local LAN.G
# house="\U1f3e0"
# houses="\U1f3d8"
# globe="\U1F310" # globe icon to mean destination on Internet.

# for path in "$@"; do # For each command line argument.
#     path=$(realpath "$path")
#     echo "Sending $path to:"
#     # directory_path="$(dirname $path)"
#     for destination in $destinations  ; do
#         target="$destination"
#         if [[ $target == *"@"* ]]; then # Destination is remote path/eh/...
#             target_icon="$globe" # globe
#         else
#             target_icon="$house" #  
#         fi
#         if [[ "$destination " == *"$(hostname)"* ]]; then
#             # echo -e "$okay      $home Local system"
#             continue
#         fi
#         host="${destination%%:*}" # Strip off the : and directory path.
#         host="${host##*@}" # Remove the username@ prefix.
#         if timeout 2 gethostip $host  >/dev/null; then # server is reachable.
# 	    # EH Workface
# 	    echo "rsync $path $destination$destination_directory"
#             start=$SECONDS
#             echo -e "$indent$arrow $target_icon $target"
#             if rsync "$path" "$destination$destination_directory" \
# 		     -haAX --no-i-r --update --archive \
#                      --recursive  --human-readable --info=progress2 \
#                      --exclude=cache --exclude=cache2 --exclude='.cache' \
# 		     --exclude=Trash --exclude=saved-telemetry-pings \
#                      -e "ssh -T -c aes128-ctr -o Compression=no -x"; then
#                 elapsed=$(( $SECONDS - start ))
#                 elapsed_string=$(date -d@"$elapsed" -u +%-M:%S)
#                 status="$okay"
#             else
#                 status="$not_okay"
#                 exit 1
#             fi
#             echo -e -n "\033[2A\033[2K" # up 1, clear entire line
#             echo  -e "$status $elapsed_string $target_icon $destination$destination_directory"
#             # echo ""
#             echo -e -n "\033[K"

#         else
#             # echo "$destination not reachable."
#             continue # This destination isn't there, go to the next.
#         fi
#     done
#     echo "" # blank line between items to send
# done
# # echo "Sent $1 $?"
# exit $?
