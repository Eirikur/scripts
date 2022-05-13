#!/bin/bash
# Named setup.sh on 6/9/2015
#set -x # Trace
#set -e # Exit on error
# 8 Nov 2012: This is now quantal.sh for Ubuntu 12.10 Quantal Quetzal
# 18 Apr 2013: Moved to Linux Mint 14
echo 'RasPi installations...'
# Fix Apport annoying dialogs that you can't do anything about.

# gksu gedit /etc/default/apport
# and change "enabled" from "1" to "0", then save the file.

# Tell BASH to expand aliases.
shopt -s expand_aliases

echo 'Enabling sudo'
sudo adduser eh sudo
sudo echo 'eh  ALL=(ALL) NOPASSWD:ALL' | sudo tee -a /etc/sudoers.d/eh # tee hack avoids IO redirect which does not work.
echo "Done with sudo enablement."

echo "Defining commands..."
# install-suggests is evil and installs a TON of stuff I don't want!!!!
alias add='sudo apt-get -yuV install --install-recommends -qq'
alias repo='yes | sudo add-apt-repository -y'
##alias getkey='sudo apt-key'
alias update='sudo apt-get -qq update' # -qq is safe here.
alias check='sudo apt-get check -qq'
alias purge='sudo apt-get autoremove -qq; sudo apt-get autoclean -qq'
alias rm='sudo apt-get -yuV remove -qq'

echo "Go...."
l, 
echo "Getting lastest repository information..."
update
echo "Repairing installed software database if needed..."
sudo apt-get install --fix-broken --fix-missing --assume-yes --force-yes


echo "Adding my basic software...."
# My core applications
add htop gparted zile emacs24 emacs-goodies-el emacs24-el emacs24-common-non-dfsg guake gkrellm gkrellm-ibam gkrelltop gkrellmwireless gkrellweather autokey-gtk firefox libnss-myhostname openssh-server sshfs openssh-blacklist openssh-blacklist-extra

echo "Function-key user interface stuff..."
add wmctrl xdotool autokey-gtk # control window manager via scripts.

echo "Installing gkrellm Multiping Pinger..."
# Pinger
sudo ~/Customizations/gkrellm/install.sh

# Fix broken Cinnamon Settings
gsettings reset-recursively org.cinnamon

# Last thing
echo 'Installation complete. Doing final repository update and local purge...'
check
update
purge
check
echo 'Done with managed packages.'
echo 'Updating APT Xapian Index...'
sudo update-apt-xapian-index
