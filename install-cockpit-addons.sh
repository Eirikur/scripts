#!/bin/bash

sudo apt install cockpit attr coreutils libc-bin nfs-kernel-server samba samba-common-bin systemd winbind gawk

git clone https://github.com/45Drives/cockpit-file-sharing.git
cd cockpit-file-sharing
make
sudo make install

git clone https://github.com/optimans/cockpit-zfs-manager.git
sudo cp -r cockpit-zfs-manager/zfs /usr/share/cockpit

