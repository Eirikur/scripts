#!/bin/bash
source='/home/eh/Customization'
host='onyx.local'

indent="  "
okay="\U1f197"
not_okay="\U1f534"
arrow="\u2B95"


if tar -cf - $source 2>/dev/null | \
    mbuffer -s 1M -m 4G | zstd -z --adapt --rsyncable | \
    ssh -T -c aes128-ctr -o Compression=no -x $host \
        "mbuffer -s 1M -m 64M > /Fast/eh.tar.zstd"; then
    elapsed=$(( $SECONDS - start ))
    elapsed_string=$(date -d@"$elapsed" -u +%-M:%S)
    status="$okay"
else
    status="$not_okay"
fi
# echo -e -n "\033[1F\033[2K" # up 2, clear entire line
echo  -en "$indent$elapsed_string  $host $status"
echo ""
# echo -e -n "\033[K"
