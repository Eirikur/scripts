#!/bin/bash
# Push a file to the remote version of working directory.  Strip home off.
# 9 May 2018, Patricia's birthday. Quoted $1 to "$1"
# 6 Aug 2019, added -z to enable compression
# echo "Sending $1"
# time rsync --times --update --stats --archive --partial --partial-dir=~/.rsync-partial
#     --compress --compress-level=9
# set -e # break on error.

# So, compress with no options is gzip with level 6
# set -x
# set -e
offsite_user='9185'
offsite_host='usw-s009.rsync.net'
#destinations="tma-1.local onyx.local z.local black.local $offsite_host"
#destinations="tma-1.local z.local black.local $offsite_host"
# if timeout 1 gethostip silver.local >/dev/null; then
#     destinations="$destinations"
# else
#     echo "Silver is not reachable."
# fi
# /usr/bin/time -f%E 

for path in "$@"; do # For each command line argument.
    du -h --summarize "$path"
    for destination in $destinations  ; do
        target="$destination"
        # If our own hostname, ignore it.
        if [[ "$destination " == *"$(hostname)"* ]]; then
            echo "$destination is local."
            continue
        fi
        if timeout 5 gethostip $destination  >/dev/null; then # server is reachable.
            if [[ "$destination" == "$offsite_host" ]]; then # Offsite host requires username.
                destination="$offsite_user@$offsite_host:eh/${PWD##/home/eh}"; # Offsite has eh dir inside the account root.
            else
                destination="$destination:${PWD#/home/eh}"
            fi
            echo "Sending $path to $destination"
            /usr/bin/time -f%E rsync "$path" "$destination"  -haAX --no-i-r --noatime --update --archive \
                          --info=progress2 --human-readable \
                          --exclude=cache --exclude='.cache' --exclude=Trash --exclude=saved-telemetry-pings \
                          -e "ssh -T -c aes128-ctr -o Compression=no -x"
        else
            echo ""
            echo "$destination not reachable."
            echo ""
            continue # This destination isn't there, go to the next.
        fi
    done
done
# echo "Sent $1 $?"
exit $?
  
