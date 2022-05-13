#!/bin/bash
# Eirikur Hallgrimsson 8 Oct. 2013

emacsclient $1

if (( $? )); then
    # No emacs server exists and the client bailed out with non-zero status
    echo "No Emacs server present.  We'll have to start one."
    /usr/bin/emacs -e server-start
fi
