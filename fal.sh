#!/bin/bash

while :
do
    killall mbuffer
    mbuffer -I 4242 | tar -vxf -
    sleep 5
done
