#!/usr/bin/env bash
blocks_on_media="$1/__ZEROS__"
/usr/bin/time -f%E sudo dd if=/dev/zero of="$blocks_on_media" bs=8M status=progress
echo "Written."
/usr/bin/time -f%E sudo dd if="$blocks_on_media" of=/dev/null bs=8M status=progress
echo "Read."
sudo rm "$blocks_on_media"
echo "Removed huge temporary file."
