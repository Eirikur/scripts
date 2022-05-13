#!/bin/bash
killall -KILL jackd

sound_card='USB Audio DAC'

killall jackd # let's start jackd fresh.
killall -KILL jackd # In case it was really hung up.

# List alsa devices
aplay -l | grep "$sound_card"| while read line
do
    DEVICE=$(echo $line | cut -f1 -d ':' | cut -f2 -d ' ')
    echo $DEVICE
    /usr/bin/jackd --silent -v -dalsa -dhw:$DEVICE,0 2&>1 ~/jackd.log & disown
    break
done
