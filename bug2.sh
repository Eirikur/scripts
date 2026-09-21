#!/bin/bash

# Set up the client to start the server if that's needed.
# The client then connects.
alias emacsclient='emacsclient "$1" --alternate-editor="emacs"'

set -x

if [[ $(emacsclient -e '(visible-frame-list)' | grep "$HOSTNAME" | head -c1 | wc -c) -ne 0 ]]; then 
    echo "Found in visible frame list ."
    emacsclient -e '(hide-everything)'
else 
    emacsclient -e '(make-frame-visible)'
    # if [[ $(emacsclient -e '(visible-frame-list)' | grep "$HOSTNAME" | head -c1 | wc -c) -ne 1 ]]; then 
    #     emacsclient -c
    # fi
fi
 
