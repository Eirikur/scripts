#!/bin/bash
cd ~/Projects/External
git clone https://github.com/45Drives/cockpit-zfs-manager.git 
sudo cp -r cockpit-zfs-manager/zfs /usr/share/cockpit
cd -
