#!/bin/bash

cd ~/Projects/External
git clone https://github.com/dankamongmen/notcurses.git
echo 'Requirements fullfillment...'
sudo apt-get install build-essential cmake doctest-dev zlib1g-dev libavformat-dev libavutil-dev libgpm-dev libncurses-dev libreadline-dev libqrcodegen-dev libswscale-dev libunistring-dev pandoc pkg-config
sudo apt-get install python3-cffi python3-dev python3-pypandoc python3-setuptools
echo 'Rustaceanisms...'
sudo apt-get install cargo bindge
