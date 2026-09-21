#!/bin/bash
# Eirikur Hallgrimsson 16 May 2020 Covid lockdown
# 2022 April fixed to use command -v
exec &> >(tee -a "toggle-emacs.log")
date # for log files.txt
# cd ~/.emacs.d # For now, it would be useful for Emacs to have this default dir.

title="ξmacs:"
target_file="$1"

# Pardon my debugging:
# notify-send "$title $target_file" &
set -x

if xdotool &>/dev/null search $title; then # Window manager cases.
    echo 'Emacs window exists.'
    id=$(xprop -root _NET_ACTIVE_WINDOW | cut -d ' ' -f5 )
    echo "Existing Emacs window id: $id"
    name=$(xprop -id $id WM_NAME) #   | cut -d ' ' -f3 ) #| ytr -d '"')
    echo "Top window: $name"
    if [[ $name == *"$title"* ]]; # If one of our windows is on top...
    then
	echo "Window is on top. Hiding it..."
	wmctrl -r "$title" -t 1 # Send window off to desktoop 1 to hide.
	exit
    else
	echo "Window is not on top; raise it."
	wmctrl -R "$title"
	echo "Window fetched and raised."
	IFS='x' read sw sh < <(xdpyinfo | grep dimensions | grep -o '[0-9x]*' | head -n1)
	read wx wy ww wh < <(wmctrl -lG | grep $title | sed 's/^[^ ]* *[^ ]* //;s/[^0-9 ].*//;')
	wmctrl -r $title -e 0,$(($sw/2-$ww/2)),$(($sh/2-$wh/2)),$ww,$wh
	echo "Window centered."
    fi

else # Window manager doesn't have an Emacs window. We must start Emacs.
    echo "No Emacs window exists. Starting a server via emacsclient..."
    if emacsclient -e "(emacs-version)" -nca '' &>/dev/null ; then
	echo "emacslient returned a success status."
    else
	echo "Emacslient returned a failed status."
	killall emacs emacs-gtk; killall -KILL emacs emacs-gtk
	echo "Launching a Emacs daemon..."
	if emacs --daemon ; then
	    echo "Emacs daemon launched."
	    emacsclient -n -c -e "(message "Toggled into existence.")"
	else
	    echo "Emacs daemon failed to launch. One more try..."
	    emacsclient -n -c -e "(message "Toggled into existence.")"
	fi
    fi
fi # End of entire flow.

if test -z target_file;
then
    emacsclient -n -r "$target_file"
fi

# Wasn't ending up with focus.
wmctrl -R "$title"
emacsclient -n -e "(x-focus-frame nil)"
sleep 3 && wmctrl -R "$title"

echo # A blank line for the log file.
exit 0
