#!/bin/bash

title='dmesg-popup'

wmctrl -R "$title" # Try to raise our window.
if (( $? )); then # Window did not exist.
    gnome-terminal -t "$title" --profile=dmesg -- dmesg -wT # & disown
fi
