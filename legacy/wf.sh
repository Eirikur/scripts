#!/bin/bash
#xfreerdp -f -x m -z -a 32 -g 1900x1024 -u eh -p eh123eh 192.168.1.67 # Most primitive UI on remote.
# l = lan, assume we can do most UI effects.
xfreerdp -x l -z -a 32 -g 1920x1200 -u "AD-ENT\U336497" -p "EH1$well" 192.168.1.119 # Best UI on remote
