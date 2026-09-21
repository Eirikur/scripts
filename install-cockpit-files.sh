#!/usr/bin/env bash
mkdir -p ~/Projects/External
cd ~/Projects/External
sudo rm -rf cockpit-files
sudo rm -rf /usr/share/cockpit/files

git clone https://github.com/cockpit-project/cockpit-files.git
cd cockpit-files
sudo make install

#installs to /usr/local/share/
sudo mv /usr/local/share/cockpit/files /usr/share/cockpit/
cd -


