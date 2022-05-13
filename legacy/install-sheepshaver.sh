#!/bin/bash

# sudo apt-get install build-essential git
sudo apt-get install libgtk2.0-dev x11proto-xf86dga-dev libxxf86dga-dev libxxf86dga1 libsdl1.2-dev 

# Note: the libesd0-dev package is not available for Ubuntu 18.04 LTS.

# Then clone official repository of the project and compile the application:

cd ~/Projects/
mkdir -p macemu

git clone https://github.com/kanjitalk755/macemu
cd macemu/BasiliskII/src/Unix
NO_CONFIGURE=1 ./autogen.sh
./configure --enable-sdl-video=yes --enable-sdl-audio=yes --with-bincue
make
strip BasiliskII


git clone https://github.com/kanjitalk755/macemu
cd macemu/SheepShaver
make links
cd src/Unix
NO_CONFIGURE=1 ./autogen.sh
./configure --enable-sdl-video=yes --enable-sdl-audio=yes --with-bincue
make
strip SheepShaver

cd macemu/BasiliskII/src/Unix/Linux/NetDriver
make
sudo make dev
sudo chown [user account] /dev/sheep_net
sudo make install
sudo modprobe sheep_net4








# cd ~/Projects
# git clone https://github.com/cebix/macemu.git
# cd SheepShaver
# make links

# cd src/Unix/
# ./autogen.sh
# make -j3
