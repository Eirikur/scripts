#!/bin/bash
# RPi official Touchscreen dimensions
Xephyr  -br -ac -noreset -screen 800x480 :1 &
#Xephyr  -br -ac -noreset -screen 1500x800 :1 &
cd ~/Projects/Pi/MagicMirror
DISPLAY=:1 npm start
