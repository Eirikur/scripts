#!/bin/bash
killall jackd # let's start jackd fresh.
killall -KILL jackd # In case it was really hung up.
sound_card='USB Audio DAC'
pacmd set-default-sink 0 # Free up my USB DAC by moving the default output.
set -x
# List alsa devices
aplay -l | grep "$sound_card"| while read line
do
    DEVICE=$(echo $line | cut -f1 -d ':' | cut -f2 -d ' ')
    echo $DEVICE
    /usr/bin/jackd -v -dalsa -dhw:$DEVICE,0 2&>1 ~/jackd.log & disown
    break
done


sleep 3
~/Applications/setBfree/bin/setBfreeUI &
sleep 1
jack_connect system:midi_capture_2 'setBfree DSP Tonewheel Organ:control'
jack_connect 'setBfree DSP Tonewheel Organ:outL' system:playback_1
jack_connect 'setBfree DSP Tonewheel Organ:outR' system:playback_2
echo 'Done.'
