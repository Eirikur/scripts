#!/bin/bash

lines="$(cat $1)"

for line in $lines; do
    echo "$line"
    read
    eval " $line"
done
