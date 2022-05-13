#!/bin/bash
# 10 Aug 09
cd ~/
########################## find  ~/.thunderbird/ -name *.msf -print0 | xargs --null -0 rm -v

alias push='~/scripts/push.sh'
echo "Thunderbird email..."
time tar -czf ~/thunderbird-folder.tar.gz ~/.thunderbird
echo "Firefox web browser..."
time tar -czf ~/firefox-folder.tar.gz ~/.mozilla

read -p "Archives created, ready to push. <Enter>:" q
~/scripts/push.sh ~/thunderbird-folder.tar.gz && rm thunderbird-folder.tar.gz
~/scripts/push.sh ~/firefox-folder.tar.gz && rm firefox-folder.tar.gz

cd -
pwd
