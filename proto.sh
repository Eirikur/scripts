#!/bin/bash
source="${1:-.}" # First parameter defaults to ".".
dest="$2"
kind="${3:-'d'}"
# echo "kind: $kind"A
# echo "source: $source"
# set -e; set -x
# echo "root, destination, type"

time find "$source" -type "$kind" -iname "*[:space:]*" # >/dev/null

# set +e; set +x
