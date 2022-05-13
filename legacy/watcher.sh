#!/bin/bash
while true
do
    
    fswatch -10 /var/log | xargs -0 -n 1 -I {} sleep 5 && \
        /usr/bin/gnome-terminal --profile=Glances --full-screen -- dmesg -wT
done
