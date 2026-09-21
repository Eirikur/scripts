#!/bin/bash
# Eirikur Hallgrimsson 6 Sept. 2010
# Time-stamp:<>

# argument="$1"
# if [ -z "$argument" ]
# then # $1 is empty
#     argument="--eval (recentf-open-files)"
# fi

# if [ -z "$1" ]; then
#     param="$1";
#     else param=

# set -x

# Try to raise an existing Emacs window.
# if wmctrl -R 'ξmacs:' ; then ## There is an emacs window. Assume there is a server.
if xdotool search 'ξmacs:' windowactivate ; then ## There is an emacs window. Assume there is a server.
    echo "Emacs has a window. Used: xdotool search 'ξmacs:' windowactivate"
    # xdotool search 'ξmacs:' windowactivate
else 
    echo "No Emacs window. Using: $startemacs"
    $startemacs & # Has argument and server to launch baked-into command above
    disown
    exit 0
fi
