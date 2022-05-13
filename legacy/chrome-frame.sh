#!/bin/bash
RND_DIR=/tmp/$RANDOM
mkdir -p "$RND_DIR"
echo "$1"
chromium --app="$1" \
         --user-data-dir=$RND_DIR \
         --chrome-frame \
         --window-size=1500,1728 \
         2>&1 > ~/chrome-frame.log & disown
rm -R $RND_DIR
