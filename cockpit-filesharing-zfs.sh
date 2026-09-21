#!/bin/bash
mkdir -p ~/Projects/External
cd ~/Projects/External

git clone https://github.com/45Drives/cockpit-file-sharing.git
cd cockpit-file-sharing
make
sudo make install

git clone https://github.com/optimans/cockpit-zfs-manager.git
sudo cp -rauvx cockpit-zfs-manager/zfs /usr/share/cockpit

cd -

