#!/bin/bash

sudo killall -KILL autokey
sudo killall -KILL autokey-gtk
sleep 5
sudo killall -KILL autokey
sudo killall -KILL autokey-gtk

while [ 1 ]
do
    autokey-gtk
    notify-send "Oops, autokey did it again."
    sudo killall -KILL autokey
    sudo killall -KILL autokey-gtk
    sleep 5
    sudo killall -KILL autokey
    sudo killall -KILL autokey-gtk
    sleep 10 # Allow time to kill or otherwise cope.
done
