#!/bin/bash

for var in "$1"
do
    echo "$var..."
    /usr/bin/time -f%E tar -xf $var && rm $var
done
