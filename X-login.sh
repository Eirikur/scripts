#!/bin/bash
# set -x
# Exit if this is an interactive shell. Preventing weird Onyx problem.

if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
    source ~/.profile
    return
fi

# Was defaulting to low-res. Perhaps I
# could fix by changing, changing back
# and re-saving in the Display settings.
# xrandr --output HDMI-1 --mode 3840x2160

# autokey-gtk &
# sxhkd & disown
# systemctl daemon-reload --user
# systemctl start emacs --user

# ~/Projects/j/wrapper.sh &

pgrep sxhkd || sxhkd &


# redshift-gtk &
# guake &


gkrellm & 

# # Must get back to dear old j.
# /home/eh/Projects/j/jp.py &
# /home/eh/Projects/j/dialog.py &

notify-send "X Login finished."
