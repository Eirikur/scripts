#!/bin/bash
# Eirikur Hallgrimsson 16 May 2020 Covid lockdown
# 2022 April fixed to use command -v

# Do we have the snapshot version installed?
# if command -v emacs-snapshot &> /dev/null
# then
#     echo "Using emacs-snapshot."
#     emacsclient='emacsclient-snapshot'
#     emacs='emacs-snapshot'
# else
#     echo "Using ordinary /usr/bin/emacs"
#     emacsclient='emacsclient'
#     emacs='emacs'
# fi

version='-snapshot'

echo "Using /usr/bin/emacs$version"
emacsclient="emacsclient$version"
emacs="emacs$version"



title='ξmacs'

if xdotool &>/dev/null search $title; # Does our window exist, showing that our app is running?
then
    echo 'window exists'
    id=$(xprop -root _NET_ACTIVE_WINDOW | cut -d ' ' -f5 )
    name=$(xprop -id $id WM_NAME) #   | cut -d ' ' -f3 ) #| tr -d '"')
    echo $name
    if [[ $name == *"$title"* ]]; # If one of our windows is on top.
    then
        echo 'window is on top'
        xdotool &>/dev/null search $title windowminimize %@
    else # None of our windows are the uppermost.  Raise all of them.
        echo 'none of our windows is on top; raise all of them'
        exec xdotool &>/dev/null search $title windowactivate %@
        # xdotool &>/dev/null search $title windowfocus %@
    fi
    echo "No window."
fi

if $emacsclient --eval "(emacs-version)" ; then
    echo "Server exists."
    $emacsclient --eval "(recently-show)" -nc # No wait
else
    echo "Script can't find emacs server."
    notify-send "Emacs Server starting..."
    $emacs --daemon &> ~/emacs.log
    $emacsclient -nc --eval "(recently-show)"

fi

exit 0
