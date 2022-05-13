#!/bin/bash
# echo "Defining commands..."
# # install-suggests is evil and installs a TON of stuff I don't want!!!!
# alias add='sudo apt-get -yuV install --install-recommends -qq'
# alias repo='yes | sudo add-apt-repository -y'
# ##alias getkey='sudo apt-key'
# alias update='sudo apt-get -qq update' # -qq is safe here.
# alias check='sudo apt-get check -qq'
# alias purge='sudo apt-get autoremove -qq; sudo apt-get autoclean -qq'
# alias remove='sudo apt-get -yuV remove -qq'
# alias build-dep='apt-get -qq -y build-dep'
# echo 'Adding build-essental...'
# add build-essential # General build environment for binaries.
# echo 'Adding Emacs dependencies...'
# build-dep emacs24 # Get all the libraries required
# echo 'Removing postfix which was installed as an Emacs dependency...'
# remove postfix

# mkdir ~/temp
# cd ~/temp
# echo 'Getting Emacs source...'
# wget http://ftp.gnu.org/gnu/emacs/emacs-24.4.tar.gz
# tar -xzvf emacs-24.4.tar.gz
# rm emacs-24.4.tar.gz
# cd emacs-24.4
# echo 'Building Emacs...'
# ./configure --prefix=/usr
# make -j10
# echo 'Installing Emacs into /usr'
# sudo make install
# cd -
# rm -rf ~/temp
