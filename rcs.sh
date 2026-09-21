#!/bin/bash
# From a post by Jeff Geerling.
rclone copy \                                                                       
  --multi-thread-streams=32 \
  --progress --links --metadata \
  "$1" "$2"
