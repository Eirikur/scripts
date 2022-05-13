#!/bin/bash
# set persistant spindown timeout for hard drives
# Arg: /dev/sdXX # S60 is 5 min expressed in the weird way hdparm requires
sudo hdparm -k1  -S60 $1 # Set spin-down timer and set drive to keep it. K1 wasn't working.
sudo hdparm -B 1 -Y $1 # Spin down now.
sudo hdparm -B 255 $1 # Disable APM so that drive will stay spun down.
