#!/bin/bash
# echo "Backup starting" | ~/scripts/notify.sh
# ~/coffee/mysync.coffee /home/eh eirikurh@eirikur.net:
export PATH=~/local/bin:${PATH}
export PATH=~/local/share/man:${PATH}
# Existing files (on destination) only is a new feature of cs2 on 24 April 2012
~/coffee/cs2.coffee 192.168.1.200:eh /home --existing
