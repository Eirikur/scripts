#!/bin/bash

echo "$@"

/usr/bin/gnome-terminal --profile=Glances --full-screen -- dmesg -wT
