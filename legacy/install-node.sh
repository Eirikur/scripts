#!/bin/bash
# sudo apt-get install curl python-software-properties
# curl -sL https://deb.nodesource.com/setup_13.x | sudo bash -

VERSION=node_12.x
DISTRO=bionic

echo "deb https://deb.nodesource.com/$VERSION $DISTRO main" | sudo tee /etc/apt/sources.list.d/nodesource.list
echo "deb-src https://deb.nodesource.com/$VERSION $DISTRO main" | sudo tee -a /etc/apt/sources.list.d/nodesource.list
sudo apt update && sudo apt-get install -y nodejs
