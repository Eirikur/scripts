#!/bin/bash

echo "deb http://apt.pi-top.com/pi-top-os sirius main contrib non-free" | sudo tee /etc/apt/sources.list.d/pi-top.list &> /dev/null

curl https://apt.pi-top.com/pt-apt.asc | sudo apt-key add

sudo apt update


sudo apt install --no-install-recommends -y pt-device-manager pt-sys-oled pt-firmware-updater



