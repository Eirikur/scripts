#!/bin/bash
sleep 15
while true
do
    sudo fswatch -1 -0 -o /var/log/syslog | xargs -0 -n 1 -I {} ~/scripts/display-dmesg.sh
    sleep 10
done
#/usr/bin/gnome-terminal -- 'dmesg -wT'
#/usr/bin/gnome-terminal --profile=Glances --full-screen -- dmesg -wT
# tail -f /var/log/syslog | uniq -s 16 | lwatch -i-
