#!/bin/bash
youtube-dl --write-thumbnail --embed-thumbnail --extract-audio  --audio-format mp3 --audio-quality 0 $(xclip -o)

read -n 1 -s -r -p "Press any key to continue"
