#!/usr/bin/env bash

# tar -czf - "$1" | (pv -n -i 0.1  > backup.tgz) 2>&1 | dialog --gauge "Progress" 4 80

# # tar -czf - "$1" | (pv -n -t1 > backup.tgz) 2>&1 | dialog --gauge "Progress" 5 70

# tar -cf - "$1" | zstd

# #!/bin/bash

source="${1:-.}" # First parameter defaults to ".".
compression_argument=" $2"

out_name="${source#.}" # Strip a leading period so that the archives are not hidden.
out_name="${out_name%/}"


/bin/time -f "%E" tar -cf - "$source" |
    pv -p -t -e -a -i 0.5 -w 70 -s $(du -sb "$source" | awk '{print $1}')|
    zstd --rsyncable $compression_argument > "$out_name.tar.zst" # ; echo ""

