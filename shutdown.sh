#!/bin/bash
# Assumes you didn't type the .local domain.

argument="$1"
if [ -z "$argument" ]; then # $1 is empty
    echo "Local shutdown of $(hostname) in 5 seconds."
    echo "Ooops!"
    sleep 5
    sudo sync && sudo shutdown -h now
else
    ssh "$argument.local" "sudo sync && sudo shutdown now & disown"
fi
