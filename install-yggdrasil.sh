#!/bin/bash

sudo mkdir -p /usr/local/apt-keys
gpg --fetch-keys https://neilalexander.s3.dualstack.eu-west-2.amazonaws.com/deb/key.txt
gpg --export 569130E8CA20FBC4CB3FDE555898470A764B32C9 | sudo tee /usr/local/apt-keys/yggdrasil-keyring.gpg > /dev/null

# Add the repository into your apt sources:

echo 'deb [signed-by=/usr/local/apt-keys/yggdrasil-keyring.gpg] http://neilalexander.s3.dualstack.eu-west-2.amazonaws.com/deb/ debian yggdrasil' | sudo tee /etc/apt/sources.list.d/yggdrasil.list
sudo apt-get update

# Note: The repository also works over HTTPS - you will need to sudo apt-get install apt-transport-https and then edit the above URL so that it starts with https:// instead of http:// in /etc/apt/sources.list.d/yggdrasil.list.

# Install Yggdrasil:

sudo apt-get install yggdrasil

# Configuration will be generated automatically into /etc/yggdrasil.conf when the package is installed, and the Yggdrasil service will automatically be installed into systemd.

# Enable and start the service after install/upgrade:

sudo systemctl enable yggdrasil
sudo systemctl start yggdrasil
-
