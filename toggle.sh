#!/bin/bash
# 12 Sept. 2022, xdotool now requires command before args.
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


echo "Debug arguments: $1  $2"

# if xdotool --onlyvisible &>/dev/null search $title; # Does our window exist, showing that our app is running?
if xdotool search "$title" #; # Does our window exist, showing that our app is running?
then
    echo 'window exists'
    id=$(xprop -root _NET_ACTIVE_WINDOW | cut -d ' ' -f5 )
    name=$(xprop -id $id WM_NAME) # | cut -d ' ' -f3 ) #| tr -d '"')
    echo "name: $name"
    # set -x
    echo "$title"
    if [[ $name == *"$title"* ]]; # If one of our windows is on top.
    then
        echo 'window is on top'
        xdotool search --onlyvisible $title windowminimize %@ # windowunmap %@
    else # None of our windows are the uppermost.  Raise all of them.
        echo 'none of our windows is on top; raise all of them'
        xdotool search  $title windowmap windowactivate windowfocus %@
    fi
else # Our window does not exist; our app is not running.  Start it.
    echo "Window does not exist. Trying to create one: $command"
    set -x
    $command #  &> "~/toggle.log"
    set +x
    sleep 1
    wmctrl -R $title

    #     sleep 5
    #     xsetroot -cursor_name left_xptr &
fi

exit 0
