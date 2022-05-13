#!/bin/bash

if [ $# -eq 0 ]; then # If no arguments...
    hostname="newpi"
else
    hostname="$1"
fi



touch /media/eh/boot/ssh
echo "SSH enabled."
sudo cp  ~/Projects/Pi/wpa_supplicant.conf /media/eh/rootfs/etc/wpa_supplicant/
echo "Wireless set to Mouse42."
sudo echo "$hostname" | sudo tee /media/eh/rootfs/etc/hostname

tar -zcvf /media/eh/rootfs/home/pi/scripts.tar.gz ~/scripts ~/.bashrc
tar -zcvf /media/eh/rootfs/home/pi/Four.tar.gz ~/Projects/Pi/Four


echo "Hostname set to $hostname."
umount /media/eh/rootfs
umount /media/eh/boot
echo "Partitions dismounted."
echo "Done."
