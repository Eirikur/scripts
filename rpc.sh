#!/bin/bash
start=$SECONDS
indent="  "
okay="\U1f197"
not_okay="\U1f534"
arrow="\u2B95"
total_elapsed=0

# Added third command line par1
if [[ $@ == *--debug* ]]; then
    echo 'Tracing...'
    echo ''
fi

# Human-readable, archive-mode, preserve-ACLs, preserve extended attributes.
# set -e
# set -x
if rsync  -haAX --inplace --update --info=progress2 \
	  --exclude='Downloads' \
          --exclude='*.img' --exclude='Trash' \
          --exclude='Instruments' \
          --exclude=cache --exclude=cache2 --exclude='.cache' \
          --exclude='*.iso' --exclude='*.tar' \
          --exclude='saved-telemetry-pings' \
          -e "ssh -T -c aes128-ctr -o Compression=no -x" \
          "$1" "$2"; then
    elapsed=$(( $SECONDS - start ))
    elapsed_string=$(date -d@"$elapsed" -u +%-M:%S)
    status="$okay"
else
    status="$not_okay"
    exit 1
fi
echo -e -n "\033[1F\033[2K" # up 2, clear entire line
echo  -en "$indent$elapsed_string  "$1" "$2" $status"
echo ""
# echo -e -n "\033[K"
