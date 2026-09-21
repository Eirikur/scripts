#!/bin/bash

while true
do
    date
    sleep 900
    ~/Projects/j/dialog.py "Do it now." &
    date
done
