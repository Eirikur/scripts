#!/bin/bash
# Needs to be run as root or mount -a will fail.
# This loads all the fields from the fstab line into the named options.
while read -r name mntpoint mnttype options b1 b2
    do
        # Loop thru fstab, find all relevant mountpoints. Should cover /media & /mnt dirs.
        if [[ $mntpoint == /m* ]]; then
            # Check for existing dirs, if not found create them using the mkdir -p command
            if [ ! -d $mntpoint ]; then
                # Take action if mntpoint is missing.
                mkdir -p  $mntpoint
            fi
        fi
    done < /etc/fstab
mount -a

# need to chmod +x the script, making it executable
# currently running at boot from cron (use root or sudo crontab -e to have root privelege on boot)

#cron: sudo crontab -e (initially opens menu to select editor to use, after just opens crontab)
#edit & add: @reboot /path to script/script
#save & quit
