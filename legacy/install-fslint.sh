#!/bin/bash
mkdir -p ~/Downloads/fslint
cd ~/Downloads/fslint
wget http://archive.ubuntu.com/ubuntu/pool/main/libf/libffi/libffi7_3.3-4_amd64.deb
wget http://archive.ubuntu.com/ubuntu/pool/universe/p/pygobject-2/python-gobject-2_2.28.6-14ubuntu1_amd64.deb
wget http://archive.ubuntu.com/ubuntu/pool/universe/p/pycairo/python-cairo_1.16.2-2ubuntu2_amd64.deb

wget http://old-releases.ubuntu.com/ubuntu/pool/universe/p/pygtk/python-gtk2_2.24.0-6_amd64.deb
wget http://old-releases.ubuntu.com/ubuntu/pool/universe/p/pygtk/python-glade2_2.24.0-6_amd64.deb
wget http://old-releases.ubuntu.com/ubuntu/pool/universe/f/fslint/fslint_2.46-1_all.deb

sudo apt-get install ./*.deb



sudo add-apt-repository ppa:dupeguru/ppa
sudo apt-get update
sudo apt-get install dupeguru
