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
destinations="onyx.local z.local $offsite_host"
# if timeout 1 gethostip silver.local >/dev/null; then
#     destinations="$destinations"
# else
#     echo "Silver is not reachable."
# fi

for destination in $destinations  ; do
    # If our own hostname, ignore it.
    if [[ "$destination " == *"$(hostname)"* ]]; then
        echo "Not copying to ourselves here at $destination."
        continue
    fi

    # Outer loop
    if timeout 5 gethostip $destination  >/dev/null; then
        if [[ "$destination" == "$offsite_host" ]]; then # Offsite host requires username.
            destination="$offsite_user@$offsite_host:eh/${PWD##/home/eh/}"; # Offsite has eh dir inside the account root.
        else
            echo "${PWD##/home/eh/}"
            destination="$destination:${PWD##/home/eh/}"
        fi
        
        for path in "$@"; do

            echo "Sending $path to $destination"
            /usr/bin/time -f%E rsync "$path" "$destination" --dry-run -haAX --no-i-r --noatime --update --archive \
                          --info=progress2 --human-readable \
                          --exclude=cache --exclude='.cache' --exclude=Trash --exclude=saved-telemetry-pings \
                          -e "ssh -T -c aes128-ctr -o Compression=no -x"
        done
    else
        echo ""
        echo "$destination not reachable."
        echo ""
        continue # This destination isn't there, go to the next.
    fi
done
# echo "Sent $1 $?"
exit $?
