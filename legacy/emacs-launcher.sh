#!/bin/bash
cmd="emacsclient-snapshot -nc -a=emacs-snapshot"

#Try to raise an existing Emacs window.
wmctrl -R 'ξmacs:'
#ps -e | grep emacs

if (( $? )); then # No emacs window exists, wmctrl couldn't find one.
    echo "No Emacs window found."
    $cmd
    # disown
    # exit 0
fi
