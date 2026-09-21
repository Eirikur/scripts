#!/bin/bash

url="$1"
if [ -z "${url}" ]; then
    url="\$(xclip -o)"
fi
echo "$url"

yt-dlp --write-thumbnail --embed-thumbnail --extract-audio  --audio-format mp3 --audio-quality 0 "$url"

read -n 1 -s -r -p "Press any key to continue"
