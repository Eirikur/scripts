#!/bin/bash
#xfreerdp -f -x m -z -a 32 -g 1900x1024 -u eh -p eh123eh 192.168.1.67 # Most primitive UI on remote.
# l = lan, assume we can do most UI effects.
# o = leave audio output on the remote device.  Enables MIDI on Windows hosts.
xfreerdp -o -x l -z -a 32 -g 2560x1600 -u eh -p eh123eh 192.168.1.127 # Best UI on remote



if (( $? )); then # Bad status from xfreerdp
    echo "Bad status from xfreerdp"
    zenity --error --title="xfreerdp error" --text="Had a problem!"
fi


# WARNING: Using deprecated command-line interface!
# -a 32 -> /bpp:32
# -g 2560x1600 -> /size:2560x1600 or /w:2560 /h:1600
# -o -> /audio-mode:1
# -p ****** -> /p:******
# -u eh -> /u:eh
# -x l -> /network broadband
# -z -> /compression
# 192.168.1.100 -> /v:192.168.1.100
