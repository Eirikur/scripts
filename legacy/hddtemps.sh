#!/bin/bash
# ls /dev/sd? | grep -v SSD - | cut -d ':' -f 2 | cut -d ' ' -f 2 | xargs sudo hddtemp 2>/dev/null | cut -d ':' -f1,3

# 21 April 2022, working on storage solutions, USB, eSATA.

# Use this loop to print out the temperature because some drives don't report it otherwise.
# Using variables, template out my own line.

# This could be becoming a more serious disk status program because
# a WD My Book is taking far too long to respond to a -x.

hard_drives=$(ls /dev/sd? | cut -d ':' -f 2 | cut -d ' ' -f 2 )
echo $hard_drives
for drive in $hard_drives
do
    # hddtemp=$(sudo hddtemp "$drive" 2>/dev/null) # Warnings about no sensor.
    # if [ ! -z "$hddtemp" ]; then # Not empty
    #     sleep 0
    #     # echo 'hddtemp!'        
    #     if (echo "$hddtemp" | grep 'not available'); then # SMART not available
    #        echo 'not available'
    # bad_sectors=$(sudo smartctl -x "$drive" | grep -i reall | cut -d'-' -f4 | xargs)
    # if [ $bad_sectors != 0 ]; then echo "|$bad_sectors|"; fi
    # bad_sectors="Bad sectors: $bad_sectors"
    # hddtemp=$(sudo smartctl -x "$drive" | grep '^Current Temperature' | cut -d':' -f2 | xargs)
    # if sudo smartctl -H "$drive" | grep 'overall-health' | grep 'PASSED'; then
    #     health='Okay'; else health='NOT GOOD'; fi
    # echo "$drive  $health  $hddtemp  $bad_sectors"
    sudo hddtemp $drive
done
