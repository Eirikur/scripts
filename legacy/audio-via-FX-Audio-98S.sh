#!/bin/bash
pacmd set-default-sink "alsa_output.pci-0000_00_1b.0.analog-stereo"
pacmd set-default-sink "alsa_output.usb-Burr-Brown_from_TI_USB_Audio_DAC-00.analog-stereo"
# sudo killall pulseaudio # Linux Mint seems to restart it.





