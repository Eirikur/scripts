#!/bin/bash

pacmd set-default-sink 0 # Free up my USB DAC by moving the default output.
jackd -r -d alsa -r 44100 & # Background
sleep 3
~/Applications/setBfree/bin/setBfreeUI &
sleep 1
jack_connect system:midi_capture_2 'setBfree DSP Tonewheel Organ:control'
jack_connect 'setBfree DSP Tonewheel Organ:outL' system:playback_1
jack_connect 'setBfree DSP Tonewheel Organ:outR' system:playback_2
echo 'Done.'
