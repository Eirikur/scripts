#!/bin/bash

boot=/media/eh/boot
root=/media/eh/rootfs

echo "Configuring $1"
sudo touch $boot/ssh

echo "Wifi..."
sudo cp -v ~/Projects/Pi/wpa_supplicant.conf-40-Holyoke $root/etc/wpa_supplicant/wpa_supplicant.conf
echo "Hostname..."
sudo echo $1 | sudo tee -a /etc/hostname # tee hack avoids IO redirect which does not work.
echo "Done."
