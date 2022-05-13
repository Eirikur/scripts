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

wmctrl -R 'Wunderlist'

if (( $? )); then
    # No Wunderlist window exists, wmctrl couldn't find one.
    echo "No Wunderlist window."
    /opt/wunderlist/Wunderlist
else # There is a window
    echo "There is an Wunderlist window, so it has been raised."
fi 


