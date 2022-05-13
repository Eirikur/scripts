#!/bin/bash
# Eirikur Hallgrimsson 6 Sept. 2010
# Time-stamp:<>
# set -x
# create-frame plus new-frame was two frames! 3 Dec 2011

# param="--eval (new-frame)"
# if test -z "$1"
# then
#     echo "No arguments.  Defaulting to $param"
# else
#     param="$1"
# fi


wmctrl -R 'emacs@'

if (( $? )); then
    # No emacs window exists, wmctrl couldn't find one.
    echo "No Emacs window."
    if test -z "$1"
        then
        echo "No arguments. Try switching to previous buffer."
        emacsclient --no-wait --eval "(switch-to-previous-buffer) (new-frame)"
        else
        emacsclient --no-wait --create-frame $1 # --eval "(my-new-frame)"
    fi
    if (( $? )); then # There's no server
        echo "No Emacs daemon. emacsclient didn't find one."
        emacs --daemon; emacsclient --no-wait --create-frame $1 # --eval "(my-new-frame)"
    fi # There's no server
else # There is a window
    echo "There is an Emacs window, so it has been raised."
    emacsclient --no-wait $1
    echo "Used emacsclient to open $1."
fi 



