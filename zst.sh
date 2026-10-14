#!/bin/bash


source="${1:-.}" # First parameter defaults to ".".
out_name="${source#.}" # Strip a leading period so that the archives are not hidden.



# pv --size "$size" --format '%{bar-granular}' |

# Perplexity told me:
size=$(du -sb -- "$source" | cut -f1)
TIMEFORMAT='%3lR'
time tar -cf - "$source" |
  pv --size "$size" -i 0.1 -u granular |
  zstd --rsyncable > "$out_name.tar.zst"



# source="${1:-.}" # First parameter defaults to ".".
# alias tar='tar --exclude="/home/eh/.cache" --zstd'
# alias time='/usr/bin/time -f "%E"'
# time tar -cf - "$source" |
#     pv --format '%{bar-granular}' | zstd --rsyncable > "$source.tar.zst"
