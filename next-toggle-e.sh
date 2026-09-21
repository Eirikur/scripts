#!/bin/bash

# Set up the client to start the server if that's needed.
# The client then connects.
emacsclient="emacsclient "$1" --alternate-editor="emacs"

echo  "emacsclient = $emacsclient"

exit 0

if [[ $(emacsclient --eval '(visible-frame-list)') ]];
then
    




if [[ $($emacsclient --eval '(visible-frame-list)') ]] # | grep "$HOSTNAME" | head -c1 | wc -c ) -ne 0 ]]; --no-wait
   then
       echo "Found in visible frame list ."
       emacsclient --eval '(make-frame-invisible (selected-frame) t)'
else 
    echo "Need to raise or make a frame."
    emacsclient --eval '(progn (make-frame-visible)(raise-frame))'
    # if [[ $(emacsclient -e '(visible-frame-flist)' | grep "$HOSTNAME" | head -c1 | wc -c ) -ne 1 ]]; then 
    #     emacsclient -c
    # fi
fi

