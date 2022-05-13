#!/bin/bash
# $1, pi to back up. $2, destination.
source="$1"
unique="$(date +%s)" # Unix date (epoch) in seconds, period, nanoseconds.
root_device="\$(df -P / | tail -n 1 | awk '/.*/ { print substr(\$1, 1, length(\$1)-1)}')"
echo "$root_device"
filename="$source-$unique.img"

if [ "$destination" == "" ]; then
    destination="$HOME/Downloads/$filename"
else
    destination="$2/$filename"
fi

echo "$source -> $destination"


# status=progress; sync; echo "Complete and synced."

# Works.
# /usr/bin/time -f "%E" ssh "$source" "sudo dd if=$root_device bs=4M" | dd of="$destination" status=progress && sync && echo "Complete and synced."
/usr/bin/time -f "%E" ssh "$source" "sudo dd if=$root_device bs=4M" | dd of="$destination" status=progress && sync && echo "Complete and synced."
~/scripts/pishrink.sh -szrva 
