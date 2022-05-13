#!/bin/bash
killall -KILL jackd

SPEAKERS='alsa_output.pci-0000_00_1b.0.analog-stereo'
sound_card='GSX1000'

# pacmd set-default-sink $SPEAKERS


# List alsa devices
aplay -l | grep $sound_card| while read line
do
    DEVICE=$(echo $line | cut -f1 -d ':' | cut -f2 -d ' ')
    echo $DEVICE
    /usr/bin/jackd --silent -v -dalsa -dhw:$DEVICE,0 2&>1 ~/jackd.log & disown
    break
done

#WINEPREFIX="/home/eh/.wine" wine64 /home/eh/wine/drive_c/Program\ Files/REAPER\ \(x64\)/reaper.exe
WINEPREFIX="/home/eh/.wine" bash -c "wine64 /home/eh/wine/drive_c/Program\ Files/REAPER\ \(x64\)/reaper.exe" 2&>1 ~/reaper.log & disown
