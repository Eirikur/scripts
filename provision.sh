#!/bin/bash
destination="$1"
dirs=".config .emacs.d .gkrellm2 .profile .mozilla .ssh Applications Configuration Customization scripts"

for dir in $dirs
do
    echo "Sending $dir..."
    if rsync "/home/eh/$dir" "$destination" -haAX --no-i-r --update --archive \
             --recursive  --human-readable --info=progress2 \
             --exclude=cache --exclude=cache2 --exclude='.cache' --exclude=Trash --exclude=saved-telemetry-pings \
             -e "ssh -T -c aes128-ctr -o Compression=no -x"; then
        elapsed=$(( $SECONDS - start ))
        elapsed_string=$(date -d@"$elapsed" -u +%-M:%S)
        echo "Sent $dir in $elapsed_string"
        status="$okay"
    else
        status="$not_okay"
        echo "That did not go well."
        exit 1
    fi
done

