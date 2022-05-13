#!/bin/bash

server="red.local"
destinations="$server:/media/Upper/Backups $server:/media/Lower/Backups"

for destinations in "$destinations"
do
    for var in "$@"
    do
        echo "$var..."
        # file="$var"
        file="${var#.}" # strip the initial . that makes a file hidden.
        # unique="$(date +%s.%N)" # Unix date (epoch) in seconds, period, nanoseconds.
        # unique="$(date +%s)" # Unix date (epoch) in seconds, period, nanoseconds.
        suffix=".tar"
        file="$file$suffix"
        echo "Backing up $var"
        # Bash requires distinction of the external program.
        /usr/bin/time -f "%E" tar -cf $file $var && du -h $file && rsync -av --progress $file "$desgination" && rm $file
    done
done
