#!/usr/bin/env bash

sudo add-apt-repository ppa:gnome3-team/gnome3 -y
sudo add-apt-repository ppa:vala-team -y
sudo add-apt-repository ppa:gnome3-team/gnome3-staging -y
sudo apt install cmake valac libgtk-3-dev libgee-0.8-dev libclutter-gtk-1.0-dev libclutter-1.0-dev libwebkit2gtk-4.0-dev libclutter-gst-3.0-dev

# Eiríkur's breakout section for webkit

sudo apt update
sudo apt install libwebkit2gtk-4.0-dev
sudo apt --fix-broken install



git clone https://github.com/christianloopp/komorebi.git
cd komorebi
mkdir build && cd build
cmake .. && sudo make install && ./komorebi






