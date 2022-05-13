#!/bin/bash
#/home/eh/Applications/firefox/run-mozilla.sh /home/eh/Applications/firefox/firefox $1
wmctrl -R 'Mozilla Firefox'

if (( $? )); then
    # No window exists, wmctrl couldn't find one.
    echo "No Firefox window. Starting Firefox..."
    killall firefox
    killall -KILL firefox
    notify-send "Starting Firefox"
    ~/Applications/firefox/firefox
fi # There's no window

# There is a window
echo "There is a Firefox window.  Raising it."
exit 0
