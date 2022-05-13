#!/bin/bash

while :
do
    echo "New connection."
    mbuffer -I 4242 | zstd -d | tar -vxf -
done
