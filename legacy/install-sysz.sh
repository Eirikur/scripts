#!/bin/bash
cd ~/Projects/External/
git clone --depth 1 https://github.com/junegunn/fzf.git
./fzf/install

git clone https://github.com/joehillen/sysz.git
cd sysz
make
sudo make install
