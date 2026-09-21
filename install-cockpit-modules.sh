#!/bin/bash

# Dependencies
sudo apt install -y cockpit attr coreutils libc-bin nfs-kernel-server samba samba-common-bin systemd winbind gawk
mkdir -p ~/Projects/External
cd ~/Projects/External

# File Sharing manager is a make-install
git clone https://github.com/45Drives/cockpit-file-sharing.git
cd cockpit-file-sharing
make
sudo make install

# Indentities, user management. Package manager install. 
curl -sSL https://repo.45drives.com/setup | sudo bash
sudo apt update
sudo apt install cockpit-identities

# ZFS manager is downloaded and copied into place.
git clone https://github.com/optimans/cockpit-zfs-manager.git
sudo cp -r cockpit-zfs-manager/zfs /usr/share/cockpit




cd -
