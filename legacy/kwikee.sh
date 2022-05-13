#!/bin/bash
#xfreerdp -f -x m -z -a 32 -g 1900x1024 -u eh -p eh123eh 192.168.1.67 # Most primitive UI on remote.
# l = lan, assume we can do most UI effects.
# o = leave audio output on the remote device.  Enables MIDI on Windows hosts.
# -g 2560x1600   -z 
xfreerdp /decorations 0 -o -x l -a 32 -g 2560x1600 -u Eirikur.Hallgrimsson -p "EH3kwikee" 192.168.1.141 # Best UI on remote

if (( $? )); then # Bad status from xfreerdp
    echo "Bad status from xfreerdp"
    zenity --error --title="xfreerdp error" --text="Had a problem!"
fi


