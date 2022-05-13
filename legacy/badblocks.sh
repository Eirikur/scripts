#!/bin/bash

cleaned=$(echo "$1" | tr '/:' '_-')
echo $cleaned
time sudo badblocks -b 8192 -c 1024 -wsv -t random "$1" -o "badblocks-$cleaned.txt"




