#!/bin/bash
echo "Go."
killall -KILL sxhkd
sxhkd & disown

