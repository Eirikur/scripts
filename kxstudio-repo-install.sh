#!/bin/bash
# Update software sources
sudo apt-get update

# Install required dependencies if needed
sudo apt-get install apt-transport-https gpgv wget

# Download package file
wget https://launchpad.net/~kxstudio-debian/+archive/kxstudio/+files/kxstudio-repos_11.1.0_all.deb

# Install it
sudo dpkg -i kxstudio-repos_11.1.0_all.deb

echo 'Done installing KXstudio repositories.'
