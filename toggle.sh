#!/bin/bash
# toggle.sh
# $toggle title command
# Title is case-sensitive
# If title found in title of topmost window: hide all such windows.
# If title found, raise all such windows
# If title not found, run command to get a window.
#  set -x


title="$1" # Window title to search for.

# The second argument is optional.  If not supplied, title is used as the command.
if [ "$2" == "" ];
then
    command="$1"
else
    command="$2"
fi

if xdotool --onlyvisible &>/dev/null search $title; # Does our window exist, showing that our app is running?
then
    echo 'window exists'
    id=$(xprop -root _NET_ACTIVE_WINDOW | cut -d ' ' -f5 )
    name=$(xprop -id $id WM_NAME | cut -d ' ' -f3 ) #| tr -d '"')
    echo "name: $name"
    set -x
    echo $title
    if [[ $name == *"$title"* ]]; # If one of our windows is on top.
    then
        echo 'window is on top'
        xdotool --onlyvisible &>/dev/null search $title windowminimize %@ --sync # windowunmap %@
    else # None of our windows are the uppermost.  Raise all of them.
        echo 'none of our windows is on top; raise all of them'
        exec xdotool --onlyvisible &>/dev/null search $title windowmap windowactivate %@
        # xdotool &>/dev/null search $title windowfocus %@
        xdotool --onlyvisible &>/dev/null search $title windowfocus %@
    fi
else # Our window does not exist; our app is not running.  Start it.
    echo 'window does not exist'
    set -x
    $command
    sleep 1
    wmctrl -R $title
    set +x
    #     sleep 5
    #     xsetroot -cursor_name left_xptr &
fi
echo
exit 0
