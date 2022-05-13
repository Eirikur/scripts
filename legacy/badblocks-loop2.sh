#!/bin/bash

# 60GB Intel SATA III SSDs in Sabrent coffee can.


for drive in /dev/sdb /dev/sdg; do
    cleaned=$(echo "$drive" | tr '/:' '_-')
    echo "$drive"
    echo "$cleaned"
    /usr/bin/time -f%E sudo badblocks -b 1024 -c 1024 -wsv -t random "$drive" -o "badblocks-$cleaned.txt"
    echo "Done."
    echo ""
done


             


