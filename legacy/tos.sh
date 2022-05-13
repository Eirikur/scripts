#!/bin/bash
# 17 July 2012  hacked from emacs.sh
# Crude fix for the startup hang issue on Mint/Cinnamon Jan 2015
# Now just kill thinkTDA processes, not all Java processes, March 2015'




wmctrl -R 'thinkorswim'

if (( $? )); then
    # If @thinkorswim not found...
    echo 'No @thinkorswim window.'
    ~/Applications/thinkTDA/thinkTDA
else # There is a window
    echo 'There is an @thinkorwim window, so it has been raised.'
    wmctrl -R 'ProphetCharts' # Raise it if found.
    wmctrl -R 'Watchlist' # Raise it if found.
fi



exit 0
