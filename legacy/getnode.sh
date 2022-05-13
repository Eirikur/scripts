#!/bin/bash

curl -sL https://deb.nodesource.com/setup_11.x | sudo bash -
## Run `sudo apt install -y nodejs` to install Node.js 11.x and npm
## You may also need development tools to build native addons:
sudo apt install gcc g++ make
sudo apt install -y nodejs
## To install the Yarn package manager, run:
curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt update && sudo apt install yarn
sudo apt autoremove -y

