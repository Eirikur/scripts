#!/bin/bash
# set -x
# Exit if this is an interactive shell. Preventing weird Onyx problem.
case $- in
    *i*) exit ;;
      *) ;;
esac


# xmodmap ~/.Xmodmap
# setxkbmap -option ctrl:nocaps

# # Force my monitor configurations so that a logout will fix things.
# cp ~/Configuration/monitors.xml ~/.config/

# # Mint likes to overwrite this for some reason1
# cp ~/Configuration/firefox/profiles.ini ~/.mozilla/firefox

# xrdb ~/.Xresources

#~/scripts/emacs-loop.sh & # Don't wait for Emacs to init.


#~/scripts/dmesg-display.sh & # Background it. It doesn't like being disowned.


# /usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1 & disown

# Required for pulse equalizer.
# One can set this in /etc/pulse/default.pa
#load-module  module-dbus-protocol

# pactl load-module  module-dbus-protocol


# Still blocks Samba browsing in December 2020
# sudo killall gvfsd-smb-browse


# Mount Internal Tank as me.
# udisksctl mount -b /dev/sda1


~/Projects/j/wrapper.sh &

autokey-gtk &

emacs-snapshot --daemon &

gkrellm &





