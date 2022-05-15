#!/bin/bash

~/scripts/just_push.sh "$local_dir" "onyx.local:/Fast/Archives/"
~/scripts/just_push.sh "$local_dir" "z.local:/sas/Archives"
ssh onyx.local "mv -v /Fast/Archives /syba"
~/scripts/just_push.sh "$local_dir" "9185@usw-s009.rsync.net:$remote_dir"
