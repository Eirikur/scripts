#!/bin/bash

source="$1"
dest="$2"

alias time='/usr/bin/time -f "%E"'
set -x
time cp -rv "$source" "$dest" | pv -lep -s $(du -sb "$source" | awk '{print 1}') >/dev/null
set +x


