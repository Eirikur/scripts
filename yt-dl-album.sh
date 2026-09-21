#!/bin/bash
echo $(xclip -o)

youtube-dl --write-thumbnail --embed-thumbnail --extract-audio  --audio-format mp3 --audio-quality 0 $(xclip -o) --verbose

read -n 1 -s -r -p "Press any key to continue"
