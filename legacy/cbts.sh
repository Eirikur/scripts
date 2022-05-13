#!/bin/bash
#xfreerdp -f -x m -z -a 32 -g 1900x1024 -u eh -p eh123eh 192.168.1.67 # Most primitive UI on remote.
# l = lan, assume we can do most UI effects.
# o = leave audio output on the remote device.  Enables MIDI on Windows hosts.
# xfreerdp -o -x l -z -a 32 -g 2560x1600 -u MYUSLWRMT199057\502430725 -p P@55word 192.168.1.164 # Best UI on remote
xfreerdp -o -x l  -a 32 -g 2560x1600  -d R1 192.168.1.164 # Best UI on remote
