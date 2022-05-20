#!/bin/bash
# 10 May 2022 Allow progress bar to be shown, but then leave only one line with elapsted time on the screen.
# Bug, 9 may 2020. Putin claims winning in Ukraine during WWII V day celeb.
# Push a file to the remote version of working directory.  Strip home off.
# 9 May 2018, Patricia's birthday. Quoted $1 to "$1"
# 6 Aug 2019, added -z to enable compression
# set -x
# set -e
offsite_user='9185'
offsite_host='usw-s009.rsync.net'
offsite="$offsite_user@$offsite_host:"
destinations="onyx.local:/syba  $offsite"
indent="  "
okay="\U1f197"
not_okay="\U1f534"
arrow="\u2B95"

for path in "$@"; do # For each command line argument.
    # du -h --summarize "$path"
    directory_path="$(dirname $path)"
    for destination in $destinations  ; do
        target="$destination"
        if [[ $target == $offsite_host ]]; then
            target_icon="\U1F310" # globe
        else
            target_icon="\U1f3e1" # house with garden
        fi


        # # If our own hostname, ignore it.
        # if [[ "$destination " == *"$(hostname)"* ]]; then
        #     continue
        # fi
        # If our own hostname, ignore it.
        [[ "$destination " == *"$(hostname)"* ]] && continue
        host="${destination%%:*}" # Strip off the : and directory path.
        host="${host##*@}" # Remove the username@ prefix.
        if timeout 2 gethostip $host  >/dev/null; then # server is reachable.
            start=$SECONDS
            echo -e "$indent$arrow $target_icon $target"
            if rsync "$path" "$destination"  -haAX --no-i-r --noatime --update --archive \
                     --recursive  --human-readable --info=progress2 \
                     --exclude=cache --exclude=cache2 --exclude='.cache' --exclude=Trash --exclude=saved-telemetry-pings \
                     -e "ssh -T -c aes128-ctr -o Compression=no -x"; then
                elapsed=$(( $SECONDS - start ))
                elapsed_string=$(date -d@"$elapsed" -u +%-M:%S)
                status="$okay"
            else
                status="$not_okay"
            fi
            echo -e -n "\033[F\033[2K" # up 2, clear entire line
            echo  -en "$indent$elapsed_string $target_icon $target $status"
            echo ""
            #echo -e -n "\033[K"

        else
            # echo "$destination not reachable."
            continue # This destination isn't there, go to the next.
        fi
    done
done
# echo "Sent $1 $?"
exit $?
