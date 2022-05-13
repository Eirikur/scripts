#!/bin/bash
#xfreerdp -f -x m -z -a 32 -g 1900x1024 -u eh -p eh123eh 192.168.1.203 # Most primitive UI on remote.
# l = lan, assume we can do most UI effects.
xfreerdp -D -x l -z -a 32 -g 1900x1200 -u eh -p eh123eh 192.168.1.67 # Best UI on remote
