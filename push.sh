#!/bin/bash
# Time-stamp: <2026-08-31 20:50:31 eh>
# 10 Oct 2022 Working cleanly with the terminal control output now.
# 10 May 2022 Allow progress bar to be shown, but then leave only one line with elapsted time on the screen.
# Bug, 9 may 2020. Putin claims winning in Ukraine during WWII V day celeb.
# Push a file to the remote version of working directory.  Strip home off.
# 9 May 2018, Patricia's birthday. Quoted $1 to "$1"
# 6 Aug 2019, added -z to enable compression
# set -x
# set -e

offsite_user='de4686'
offsite_host='de4686.rsync.net'
# de4686@de4686.rsync.net


# offsite="$offsite_user@$offsite_host:eh/"
offsite="$offsite_user@$offsite_host:"

# destinations="tma-1.local onyx.local: onyx.local:/syba/eh/ z.local: $offsite"
# destinations="tma-1.local onyx.local: $offsite"
destinations="$offsite"

destination_directory="${PWD##/home/}/" # eh/path/path
# destination_directory=""
indent="  "
okay="\U1f197"
checkmark="\U2705"
okay="$checkmark" 
not_okay="\U1f534"
arrow="\u2B95"
home="\U1f3e1" # house with garden to mean local LAN.G
house="\U1f3e0"
houses="\U1f3d8"
globe="\U1F310" # globe icon to mean destination on Internet.

# Colors
red="\u001b[31m"
reset="\u001b[0m"



for path in "$@"; do # For each command line argument.
    path=$(realpath "$path")
    echo "Sending $path to:"
    # directory_path="$(dirname $path)"
    for destination in $destinations  ; do
        target="$destination"
        if [[ $target == *"@"* ]]; then # Destination is remote path/eh/...
            target_icon="$globe" # globe
        else
            target_icon="$house" #  
        fi
        if [[ "$destination " == *"$(hostname)"* ]]; then
            # echo -e "$okay      $home Local system"
            continue
        fi
        host="${destination%%:*}" # Strip off the : and directory path.
        host="${host##*@}" # Remove the username@ prefix.
        if timeout 2 gethostip $host  >/dev/null; then # server is reachable.
	    # EH Workface
	    echo "rsync $path $destination$destination_directory"
            start=$SECONDS
            # echo -e "$indent$arrow $target_icon $target"
            echo -e "$arrow $target_icon $target"
            # Free guard, no network: a destination with no colon is a LOCAL
            # path, and rsync would "succeed" writing a file literally named
            # user@host into $PWD. That bug hid in emacs-push.sh for months.
            if [[ "$destination" != *:* ]]; then
                echo "push: BUG - destination '$destination' has no colon; that is a local path." >&2
                exit 3
            fi
            if rsync "$path" "$destination$destination_directory" \
		     -haAX --no-i-r --update --archive \
                     --recursive  --human-readable --info=progress2 \
                     --exclude=cache --exclude=cache2 --exclude='.cache' \
		     --exclude=Trash --exclude=saved-telemetry-pings \
                     -e "ssh -T -c aes128-ctr -o Compression=no -x"; then
                elapsed=$(( $SECONDS - start ))
                elapsed_string=$(date -d@"$elapsed" -u +%-M:%S)
                status="$okay"

                # Confirm it really landed. PUSH_VERIFY=0 to skip the extra ssh.
                if [[ "${PUSH_VERIFY:-1}" != 0 ]]; then
                    remote_path="$destination_directory$(basename "$path")"
                    if ssh -o BatchMode=yes "${destination%:*}" \
                           ls "'$remote_path'" >/dev/null 2>&1; then
                        status="$okay"
			# echo -e "Status: $okay"
                    else
                        status="$not_okay"
                        echo "push: rsync reported success but $remote_path is not on the remote." >&2
                        exit 4
                    fi
                fi
            else
                status="$not_okay"
                exit 1
            fi

	    # echo -e -n "\033[2A\033[2K" # up 1, clear entire line
	    tput cuu1; tput cuu1; echo -en "\r";  tput el
            echo  -e "$status $elapsed_string $target_icon $destination$destination_directory"
	    tput el
            # echo ""
            # echo -e -n "\033[K"

        else
            # echo "$destination not reachable."
            continue # This destination isn't there, go to the next.
        fi # of reachable case
    done
    echo "" # blank line between items to send
done
# echo "Sent $1 $?"
# NOTE: this used to be `exit $?`, which reported the status of the echo above
# it -- always 0. Failures inside the loop exit 1 directly, so reaching here
# means everything that was reachable succeeded.
exit 0
