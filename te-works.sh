#!/bin/bash
# Eirikur Hallgrimsson 16 May 2020 Covid lockdown
# 2022 April fixed to use command -v

title="ξmacs:  "



if xdotool &>/dev/null search $title; then # Window manager cases.
    echo 'Emacs window exists.'
    id=$(xprop -root _NET_ACTIVE_WINDOW | cut -d ' ' -f5 )
    name=$(xprop -id $id WM_NAME) #   | cut -d ' ' -f3 ) #| ytr -d '"')
    if [[ $name == *"$title"* ]]; # If one of our windows is on top...
    then	
	echo "Window is on top. Hiding it..."
	wmctrl -r "$title" -t 1 # Send window off to desktop 1 to hide.
    else
	echo "Window is not on top; raise it." 
	wmctrl -R "$title"
    fi

else # Window manager doesn't have an Emacs window. We must start Emacs.
    
    echo "No Emacs window exists. Starting a server via emacsclient..."
    if emacsclient -e "(eh-start-screen)" -nca '' &>/dev/null ; then
	echo "emacslient returned a success status."
    else
	echo "Launching a looping script emacs daemon..."
	~/scripts/emacs-loop.sh
    fi
fi # End of entire flow.
exit 0
