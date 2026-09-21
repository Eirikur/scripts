#!/bin/bash
# Eirikur Hallgrimsson 16 May 2020 Covid lockdown
# 2022 April fixed to use command -v
title='ξmacs'
echo "you:"

# Does our window exist, showing that our app is running?
if xdotool &>/dev/null search $title; then
    echo 'Emacs window exists.'
    # set -x
    # set -e
    # id=$(xprop -root _NET_ACTIVE_WINDOW | cut -d ' ' -f5 )
    # name=$(xprop -id $id WM_NAME) #   | cut -d ' ' -f3 ) #| tr -d '"')
    # # echo $name
    # if [[ $name == *"$title"* ]]; # If one of our windows is on top...
    # thentrl -r "$title" -a 1 # Send window off to desktop 1 to hide.
    # fi
else  # There is no window. We need to start Emacs.
    if emaclient -n -e "(raise-frame)" -a ''; then # -a '' to start a new emacs
	echo "Started emacs via emacsclient. Window should exist."
    else
	echo "Failed to start Emacs."
    fi
fi
