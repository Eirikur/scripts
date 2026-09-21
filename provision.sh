#!/bin/bash
set -x
set -e
destination="$1"
#dirs=".config .themes .fonts .fontconfig .emacs.d .gkrellm2 .bashrc .mozilla .dirs=".config .themes .fonts .emacs.d .gkrellm2 .bashrc .mozilla .ssh Applications Configuration Customization scripts"
dirs=".config .themes .fonts .emacs.d .gkrellm2 .bashrc .mozilla .dirs=".config .themes .fonts .emacs.d .gkrellm2 .bashrc .mozilla .ssh Applications Configuration Customization scripts"

for dir in $dirs
do
    echo "Sending $dir..."
    # removed --update option because directory could be newer on the target.
    if rsync "/home/eh/$dir" "$destination" -haAX --no-i-r --archive \
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

