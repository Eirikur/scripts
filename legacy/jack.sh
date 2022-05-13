#!/bin/bash

killall -KILL jackd
killall -KILL pulseaudio
jackd -R -t 1000 -d alsa -P hw:3,0 -r 48000 -n2 -D & # REMEMBER TO CHANGE hw:0,0
sleep 3
pulseaudio &
sleep 3
# pactl load-module module-jack-sink channels=2; pactl load-module module-jack-source channels=2;pacmd set-default-sink jack_out
# pactl load-module module-jack-sink channels=2; pactl load-module module-jack-source channels=2;pacmd set-default-sink jack_out
