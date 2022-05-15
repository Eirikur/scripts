#!/bin/bash

# Listen on my port and put incoming data in /Fast

while :
do
    killall mbuffer
    mbuffer  -q -s 10M -m 30% -I 4242 | tar -C /Fast  -xf -
done
