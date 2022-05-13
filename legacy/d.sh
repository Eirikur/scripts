#!/bin/bash

source="$1"
dest="$2"
destdir="$3"

port='4242'

# Set up the listener.
nohup mbuffer -I 4242 | zstd -d | tar -xf  -
