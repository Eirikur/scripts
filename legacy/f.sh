#!/bin/bash
# set -x
if [[ ! -z $2 ]]; then # If $2 is not empty
    search_root=$1
    search_target=$2
else
    search_root='./'
    search_target=$1
fi
find "$search_root" -iname "*$search_target*" # -printf "%h\n";

