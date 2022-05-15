#!/bin/bash


source="$1"
dirname=$(dirname $(realpath $source))
source=${source%/} # Remove trailing / which might be there on directories.
filename=${source#.} # Remove leading . if present.
indent="  "
okay="\U1f197"
not_okay="\U1f534"
arrow="\u2B95"




# add back lz4 -z
start=$SECONDS
if tar -cf - "$filename" | mbuffer -m 25% -O onyx.local:4242 ; then
    elapsed=$(( $SECONDS - start ))
    elapsed_string=$(date -d@"$elapsed" -u +%-M:%S)
    status="$okay"
else
    status="$not_okay"
fi
echo -e -n "\033[F\033[K" # up 2, clear entire line
echo  -en "$indent$elapsed_string $target $status\n"
echo -e -n "\033[K"
