#!/bin/bash


source="$1"
dirname=$(dirname $(realpath $source))
source=${source%/} # Remove trailing / which might be there on directories.
filename=${source#.} # Remove leading . if present.


#echo "d $dirname"

#
# ssh z.local "$free_socket"
# ssh z.local "/home/eh/scripts/fal.sh & disown"

# exit 0

# ssh z.local "mbuffer -b 1000 -m 25% -I 4242 | tar -xf - -C $target_dir"
tar -cf - "$filename" | lz4 -z | mbuffer -m 25% -O z.local:4242




# #pv | zstd --adapt --rsyncable -z -f |


# #!/bin/bash
# # 10 May 2022 Allow progress bar to be shown, but then leave only one line with elapsted time on the screen.
# # Bug, 9 may 2020. Putin claims winning in Ukraine during WWII V day celeb.
# # Push a file to the remote version of working directory.  Strip home off.
# # 9 May 2018, Patricia's birthday. Quoted $1 to "$1"
# # 6 Aug 2019, added -z to enable compression
# # set -x
# # set -e
# offsite_user='9185'
# offsite_host='usw-s009.rsync.net'
# destinations="$offsite_host tma-1.local onyx.local z.local"
# indent="  "
# okay="\U1f197"
# not_okay="\U1f534"
# arrow="\u2B95"
# for path in "$@"; do # For each command line argument.
#     # du -h --summarize "$path"
#     directory_path="$(dirname $path)"
#     echo "$path"
#     for destination in $destinations  ; do
#         target="$destination"


#         # If our own hostname, ignore it.
#         if [[ "$destination " == *"$(hostname)"* ]]; then
#             # echo "$destination is local."
#             continue
#         fi
#         if timeout 2 gethostip $destination  >/dev/null; then # server is reachable.
#             target="$destination"
#             if [[ "$destination" == "$offsite_host" ]]; then # Offsite host requires username.
#                 destination="$offsite_user@$offsite_host:eh/${PWD##/home/eh}"; # Offsite has eh dir inside the account root.
#             else
#                 destination="$destination:${PWD#/home/eh}"
#             fi
#             start=$SECONDS
#             echo -e "$indent$arrow  $target"
#             if timeout 120 rsync "$path" "$destination"  -haAX --no-i-r --noatime --update --archive \
#                      --recursive  --human-readable \
#                      --exclude=cache --exclude=cache2 --exclude='.cache' --exclude=Trash --exclude=saved-telemetry-pings \
#                      -e "ssh -T -c aes128-ctr -o Compression=no -x"; then
#                 elapsed=$(( $SECONDS - start ))
#                 elapsed_string=$(date -d@"$elapsed" -u +%-M:%S)
#                 status="$okay"
#             else
#                 status="$not_okay"
#             fi
#             # echo -e -n "\033[2F\033[2K" # up 2, clear entire line
#             echo  -en "$indent$elapsed_string  $target $status"
#             echo ""
#             echo -e -n "\033[K"

#         else
#             # echo "$destination not reachable."
#             continue # This destination isn't there, go to the next.
#         fi
#     done
# done
# # echo "Sent $1 $?"
# exit $?
