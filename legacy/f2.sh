#!/bin/bash

dest="$1"

while :
do
    echo "New connection."
    mbuffer -I 4242 | zstd -d | tar -vxf "$dest" -
done
