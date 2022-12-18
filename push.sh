#!/bin/bash
# Time-stamp: <2022-10-10 16:18:53 (eh)>
# 10 Oct 2022 Working cleanly with the terminal control output now.
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
destinations="tma-1.local onyx.local: onyx.local:/syba/ z.local: $offsite"
destination_directory="${PWD##/home/}/" # eh/path/path

indent="  "
okay="\U1f197"
checkmark="\U2705"
okay="$checkmark"
not_okay="\U1f534"
arrow="\u2B95"
home="\U1f3e1" # house with garden
houses="\U1f3d8"

for path in "$@"; do # For each command line argument.
    directory_path="$(dirname $path)"
    for destination in $destinations  ; do
        target="$destination"
        if [[ $target == *"@"* ]]; then # Destination is remote path/eh/...
            target_icon="\U1F310" # globe
        else
            target_icon="\U1f3d8 " # houses TODO: use the variables
        fi
        if [[ "$destination " == *"$(hostname)"* ]]; then
            # echo -e "$okay      $home Local system"
            continue
        fi
        host="${destination%%:*}" # Strip off the : and directory path.
        host="${host##*@}" # Remove the username@ prefix.
        if timeout 2 gethostip $host  >/dev/null; then # server is reachable.
            start=$SECONDS
            echo -e "$indent$arrow $target_icon $target"
            if rsync "$path" "$destination$destination_directory"  -haAX --no-i-r --update --archive \
                     --recursive  --human-readable --info=progress2 \
                     --exclude=cache --exclude=cache2 --exclude='.cache' --exclude=Trash --exclude=saved-telemetry-pings \
                     -e "ssh -T -c aes128-ctr -o Compression=no -x"; then
                elapsed=$(( $SECONDS - start ))
                elapsed_string=$(date -d@"$elapsed" -u +%-M:%S)
                status="$okay"
            else
                status="$not_okay"
                exit 1
            fi
            echo -e -n "\033[2A\033[2K" # up 1, clear entire line
            echo  -e "$status $elapsed_string $target_icon $destination$destination_directory"
            # echo ""
            echo -e -n "\033[K"

        else
            # echo "$destination not reachable."
            continue # This destination isn't there, go to the next.
        fi
    done
done
# echo "Sent $1 $?"
exit $?
