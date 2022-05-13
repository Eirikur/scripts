#!/bin/bash
# Eirikur Hallgrimsson 26 Oct. 2010 Based on emacs.sh
# Time-stamp:<>

wmctrl -R 'Mozilla Thunderbird'

if (( $? )); then
    # No emacs window exists, wmctrl couldn't find one.
    echo "No Thunderbird window."
    thunderbird
fi # There's no window

# There is a window
echo "There is an Emacs window.  Raising it."
emacsclient --no-wait --eval "(my-existing-frame-is-raised)"




