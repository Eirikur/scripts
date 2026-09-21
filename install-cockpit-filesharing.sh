#!/usr/bin/env bash
mkdir -p ~/Projects/External
cd ~/Projects/External

git clone https://github.com/45Drives/cockpit-file-sharing.git
cd cockpit-file-sharing
make

if [ -d "/usr/share/cockpit/file-sharing" ]; then
    sudo rm -rf "/usr/share/cockpit/file-sharing"
fi


sudo make install

cd -


