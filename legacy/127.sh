#!/bin/bash
# echo "Backup starting" | ~/scripts/notify.sh
# ~/coffee/mysync.coffee /home/eh eirikurh@eirikur.net:
notify-send "Backup starting"
export PATH=~/local/bin:${PATH}
export PATH=~/local/share/man:${PATH}
#~/coffee/cs2.coffee /home/eh /storage > ~/cs2-monolith-storage.log
#~/coffee/cs2.coffee /home/eh /small > ~/cs2-monolith-storage.log


#~/coffee/cs2.coffee /home/eh 192.168.1.200:
~/scripts/mysync.sh /home/eh eh@192.168.1.127: # Bamboo in Worcester

