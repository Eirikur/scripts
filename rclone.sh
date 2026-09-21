#!/bin/bash
set -x
rclone sync   "$1" "$2" \                                                                       
  --multi-thread-streams=32 \
  --progress --links --metadata \

  
#  --exclude='**/._*' \
#  --exclude='.cache/*' \


  
