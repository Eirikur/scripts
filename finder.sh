#!/bin/bash
### Finds directories which match the base name of the input string.
# $1 is a fully-qualified filesystem path

path="$1"
# root=$(dirname "$path")

# "$(dirname "$(dirname "/media/eh/Scratch/000-Sampled Instruments/Philicorda")")"

root="$(dirname "$(dirname "$path")")"
echo "root: $root"
basename=$(basename "$path")

echo "Looking for instances of $basename in $root."



# find "$root" -name "$basename" -type d
set -x
for result in "$(find "$root" -name "$basename" -type d)"
do
    # echo "     $result"
    # set -x
    if ! [ "$(basename "$result")" = "$basename" ]; then 
     	echo "      $result"
    fi
    # set +x
done
  


