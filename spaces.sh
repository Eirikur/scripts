#!/bin/bash
# 10 Jul 2024
# - Deal with space in filenames.
# - Tar up each dir in a target dir.
# find   -type  d -name "*[:space:]*"
source="$1"
dest="$2"
# echo "Tarring dirs in $1, saving the  tarballs in $2."
# set -x
# find -maxdepth 1 -mindepth 1  -type  d -name "*[:space:]*" -printf "%P" -exec tar --zstd -cvf {}.tar.zst {} \;
# set +x 

[[ -z $2 ]] && echo "Requires source and destination." ; exit

set -x
cd "$source"; find -maxdepth 1 -mindepth 1 -name "*[:space:]*" -printf "'%P'\n" -exec cp -raux "{}" "$dest" \;
set +x
