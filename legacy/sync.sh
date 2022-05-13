#!/bin/bash
# Back up everything.
rsync /home/eh -a --human-readable --partial --recursive --progress --one-file-system --times --exclude='*.iso'  
