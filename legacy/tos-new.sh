#!/bin/bash
# April 16,17 2015, Eirikur

title='thinkorswim'


# echo 'sleeping...'
# sleep 2
# echo 'running...'


if xdotool search $title; # Does our window exist, showing that our app is running?
then
    echo 'window exists'
    id=$(xprop -root _NET_ACTIVE_WINDOW | cut -d ' ' -f5 )
    name=$(xprop -id $id WM_NAME) #   | cut -d ' ' -f3 ) #| tr -d '"')
    echo $name
    if [[ $name == *"$title"* ]]; # If one of our windows is on top.
    then
        echo 'window is on top'
        xdotool search $title windowminimize %@
    else # None of our windows are the uppermost.  Raise all of them.
        xdotool search $title windowactivate %@
    fi
else # Our window does not exist; our app is not running.  Start it.
    ~/Applications/thinkTDA/thinkTDA &
    sleep 12
    # xdotool search -onlyvisible thinkorswim windowactivate %1 mousemove 610 913 sleep 1 click 1 sleep 1 key --delay 10 e h 1 2 3 e h mousemove 598 999 click 1
fi
