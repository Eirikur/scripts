#!/bin/bash
# Eirikur Hallgrimsson 6 Sept. 20101
# Time-stamp:<>

# set -x
# create-frame plus new-frame was two frames! 3 Dec 2011
# Made useful again with defaulting to recentf-open-files if no file passed. 18Oct2014
# Made to work with emacsclient and server 4/11/2019

argument="$1"
if [ -z "$argument" ]
then # $1 is empty
    argument="--eval '(emacs-version'"
fi

# #argument=" "

# echo "Argument: $argument"

# emacs="emacs-snapshot"
# emacsclient="emacsclient-snapshot $argument" # -nc creates a new frame -a '' spawns a server if needed.

# if [ -z "$1" ]; then
#     param="$1";
#     else param=

# set -x


wmctrl -R 'ξmacs:  ' # Try to raise an existing Emacs window.

if (( $? )); then
    # There is no Emacs window present named 'ξmacs:  '
    echo 'No Emacs window exists'
    # If there is an emacs server
    if emacsclient-snapshot --eval "(emacs-version)" ; then
        echo "eval $?"
        echo "There is an Emacs server."
        emacsclient-snapshot $argument -na emacs-snapshot &
        disown # Allow to keep server
        exit 0
    else echo "No Emacs server present. Will start one."
         emacsclient-snapshot $argument -nca emacs-snapshot &
         disown # Allow to keep server
         exit 0
    fi

else # There is a window
    echo 'There is an Emacs window so it has been raised.'
fi



exit 0





