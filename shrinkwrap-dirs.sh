#!/bin/bas

alias time='/usr/bin/time -f "%E"'

source="${1:-.}" # First parameter defaults to ".".
dest="$2"
kind="d"
#kind="${3:-'d'}"
# echo "kind: $kind"
# echo "source: $source"
# set -e; set -x
# echo "root, destination, type"

time find "$source" -type "$kind" -iname "*[:space:]*" # >/dev/null

# set +e; set +x
