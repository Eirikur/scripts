#!/bin/bash

source="$1"
dest="$2"

tar "$1" | pv | nc

# Listener on remote system:
ssh "$server" 

#### # Split the string by space
#  readarray -d " " -t strarr <<< "$text"
