#!/bin/bash
# Eirikur Hallgrimsson 26 Oct. 2010 Based on emacs.sh
# Time-stamp:<>

wmctrl -R 'Mozilla Thunderbird'

if (( $? )); then
    # No emacs window exists, wmctrl couldn't find one.
    echo "No Thunderbird window. Starting Thunderbird..."
    thunderbird
fi # There's no window

# There is a window
echo "There is a Thunderbird window.  Raising it."
exit 0






