#!/bin/bash
echo 'blocksize set to 4096 for USB 3 WD My Books.'
# -c 4096 is a performance test.
cleaned=$(echo "$1" | tr '/:' '_-')
echo $cleaned
sudo badblocks -b 4096 -c 4096 -sv -t random "$1" -o "badblocks-$cleaned.txt"




