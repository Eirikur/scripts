#!/bin/bash
# 10 May 2022 Allow progress bar to be shown, but then leave only one line with elapsted time on the screen.
# Bug, 9 may 2020. Putin claims winning in Ukraine during WWII V day celeb.
# Push a file to the remote version of working directory.  Strip home off.
# 9 May 2018, Patricia's birthday. Quoted $1 to "$1"
# 6 Aug 2019, added -z to enable compression
# set -x
# set -e
target="$2"
host=${target%:*} # Remove ':dirname/'
host=${host#*@} # Remove username@
source="$1"
source=${source%/} # Remove trailing / which might be there on directories.
filename=${source#.} # Remove leading . if present.
indent=' '
okay="\U1f197"
not_okay="\U1f534"
arrow="\u2B95"
if timeout 2 gethostip $host  >/dev/null; then # server is reachable.
    echo -e "$indent$arrow  $host"
    start=$SECONDS # 3600 seconds == one hour
    if timeout 120 rsync "$source" "$target" -haAX --no-i-r --noatime --update --archive \
               --info=progress2 --human-readable \
               --exclude=cache --exclude=cache2 --exclude=".cache" --exclude=Trash --exclude=saved-telemetry-pings \
               -e "ssh -T -c aes128-ctr -o Compression=no -x"; then
        elapsed=$(( $SECONDS - start ))
        elapsed_string=$(date -d@"$elapsed" -u +%-M:%S)
        status="$okay"
    else
        status="$not_okay"
    fi
    echo  -en "\033[2F\033[2K" # up 2, clear entire line
    echo  -en "$indent$elapsed_string $target $status"
    echo ""
    echo  -ne "\033[K"

else
    echo -e "$host was not reachable. $not_okay"

fi
# echo "Sent $1 $?"
exit $?
