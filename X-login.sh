#!/bin/bash
xmodmap ~/.Xmodmap
# setxkbmap -option ctrl:nocaps

# # Force my monitor configurations so that a logout will fix things.
# cp ~/Configuration/monitors.xml ~/.config/

# # Mint likes to overwrite this for some reason
# cp ~/Configuration/firefox/profiles.ini ~/.mozilla/firefox

xrdb ~/.Xresources

while true; do emacs-snapshot --fg-daemon &>/dev/null; notify-send "Restarting Emacs."; done & # Will daemonize. Let it init itself in background.

#~/scripts/dmesg-display.sh & # Background it. It doesn't like being disowned.


# /usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1 & disown

# Required for pulse equalizer.
# One can set this in /etc/pulse/default.pa
#load-module  module-dbus-protocol
pactl load-module  module-dbus-protocol


# Still blocks Samba browsing in December 2020
# sudo killall gvfsd-smb-browse


# Mount Internal Tank as me.
# udisksctl mount -b /dev/sda1


# autokey-gtk & disown
# if [ $? -ne 0 ]; then
#     autokey & disown

# autokey -l & disown

gkrellm & disown
# ~/scripts/prome-theus.sh

notify-send "Logged-in."
