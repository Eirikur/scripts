#!/bin/bash
# Eirikur Hallgrimsson 7 July 2020
# Time-stamp:<>
# Look at USB storage devices to see if they support UASP.
# ! for negation. 
if ! lsusb -t | grep Driver=uas ; then
    echo "UASP not found on any USB storage device."
fi

