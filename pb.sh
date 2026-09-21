#!/bin/bash

source="${1:-.}" # First parameter defaults to ".".
compression_argument="$2"

out_name="${source#.}" # Strip a leading period so that the archives are not hidden.

alias tar='tar --exclude="/home/eh/.cache" --exclude-backups --exclude-tag-under --exclude-caches --exclude=storage'

alias time='/usr/bin/time -f "%E"'

echo "Creating $out_name.tar.gz"

/usr/bin/time -f "%E" tar -cf - "$source" |
    pv -lpe | gzip --rsyncable $compression_argument > "$out_name.tar.gz" # ; echo ""

# Below is rpush.sh
~/scripts/rpush.sh "$out_name.tar.gz" && rm "$out_name.tar.gz"

