#!/bin/bash
# Copy my home configuration to another machine.
# Usage: provision.sh HOST:[PATH]
#        DRY_RUN=1 provision.sh HOST:   # show what would be sent, copy nothing

destination="$1"
if [[ -z "$destination" ]]; then
    echo "Usage: provision.sh HOST:[PATH]   (DRY_RUN=1 to preview)" >&2
    exit 2
fi
# Without a colon rsync treats the destination as a LOCAL folder, copies
# everything there, and reports success.
if [[ "$destination" != *:* ]]; then
    echo "provision.sh: '$destination' has no colon, so it is a local path. Did you mean '$destination:'?" >&2
    exit 2
fi

dirs=".config .themes .fonts .emacs.d .gkrellm2 .bashrc .profile .ssh  .mozilla"

extra_opts=(--info=progress2)
if [[ "${DRY_RUN:-0}" != 0 ]]; then
    extra_opts=(--dry-run --stats)
    echo "DRY RUN: nothing will be copied."
fi

for dir in $dirs
do
    echo "Sending $dir..."
    start=$SECONDS
    # removed --update option because directory could be newer on the target.
    if rsync "/home/eh/$dir" "$destination" -haAX --no-i-r --archive \
             --recursive --human-readable "${extra_opts[@]}" \
             --exclude=cache --exclude=cache2 --exclude='.cache' --exclude=Trash --exclude=saved-telemetry-pings \
             -e "ssh -T -c aes128-ctr -o Compression=no -x"; then
        elapsed=$(( SECONDS - start ))
        elapsed_string=$(date -d@"$elapsed" -u +%-M:%S)
        echo "Sent $dir in $elapsed_string"
    else
        echo "That did not go well."
        exit 1
    fi
done
