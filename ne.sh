#!/usr/bin/env bash
wmctrl -R "ξmacs:"

# our_name="ξmacs:"

# set -x
# set -e


# if [[ $(wmctrl -l) =~ "$our_name" ]]; then # Our name is in the window list
#     echo "$our_name found in window list."
#     if  [[ $(wmctrl -R "$our_name") ]]; then # Wmctrl thinks it raised the window.
# 	echo "$our_name raised."
# 	exit
#     fi
# else
#     echo "$our_name not in window list."
#     killall emacs
#     emacs
# fi
