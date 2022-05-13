#!/bin/bash
echo 'Hostname:'
read hostname
# set -x
touch /media/eh/boot/ssh
sudo cp ~/Projects/Pi/wpa_supplicant.conf /media/eh/rootfs/etc/wpa_supplicant/
echo "$hostname" | sudo tee /media/eh/rootfs/etc/hostname
sudo cp -raux ~/scripts /media/eh/rootfs/home/pi/
sudo cp -raux ~/.gkrellm2/ /media/eh/rootfs/home/pi/
umount /media/eh/boot
umount /media/eh/rootfs/
