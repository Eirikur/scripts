#!/bin/bash
qsynth -m alsa_seq -a alsa -o audio.alsa.device=hw:2 $1 &
sleep 3
aconnect 32 128
