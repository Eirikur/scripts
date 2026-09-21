#!/bin/bash
# I admit that basic.sh is now really a full setup# Python
# Named setup.sh on 6/9/2015
#set -x # Trace
#set -e # Exit on error
# 8 Nov 2012: This is now quantal.sh for Ubuntu 12.10 Quantal Quetzal
# 18 Apr 2013: Moved to Linux Mint 14

# Fix Apport annoying dialogs that you can't do anything about.

# gksu gedit /etc/default/apport
# and change "enabled" from "1" to "0", then save the file.

# set -e

# No can do this without wrapping the whole thing in a function.
# alias time='/usr/bin/time -f "%E"

# Tell BASH to expand aliases.
shopt -s expand_aliases

#set -e # Exit on error.

echo 'Enabling sudo'
sudo adduser eh sudo
sudo echo 'eh ALL=(ALL) NOPASSWD:ALL' | sudo tee /etc/sudoers.d/eh # tee hack avoids IO redirect which does not work.
echo "Done with sudo enablement."

# Useful test for string in contents of file
if [[ -z `sudo cat /etc/sudoers | grep "SYSTEMD_PAGER"` ]] # If string is not there
then
    echo "Bannish systemctl's paging behavior..."
    sudo echo 'Defaults        env_keep += "SYSTEMD_PAGER"' | sudo tee -a /etc/sudoers # tee hack avoids IO redirect which does not work.
else
    echo "SYSTEMD_PAGER is disabled."
fi

echo "Fixing interrupted installation..."
sudo dpkg --configure -a

# get-deb for installing packages from other distributions.
sudo apt install curl lsb-release wget
curl -sL https://raw.githubusercontent.com/wimpysworld/deb-get/main/deb-get | sudo -E bash -s install deb-get

# echo 'Configuring loop devices...'
# sudo echo 'options loop max_part=31' | sudo tee -a /etc/modprobe.d/loop_device.conf

echo "Defining installation commands..."
# install-suggests is evil and installs a TON of stuff I don't want!!!!
# alias add='sudo apt-get -yuV install --install-recommends -qq'
# Added noninteractive 19-Aug-2023 when installing Mint to merlot and bamboo laptops.
alias add='sudo DEBIAN_FRONTEND=noninteractive apt-get -yuV install --install-recommends -qq '
alias repo='yes | sudo add-apt-repository -y'
##alias getkey='sudo apt-key'
alias update='sudo apt-get -qq update' # -qq is safe here.
alias check='sudo apt-get check -qq'
alias purge='sudo apt-get autoremove -qq; sudo apt-get autoclean -qq'
alias rm='sudo apt-get -yuV remove -qq'
alias overwrite='sudo apt-get -o Dpkg::Options::="--force-overwrite" install --reinstall -y'

echo "Starting apt package installations..."
echo "Repairing installed software database if needed..."
sudo apt-get install --fix-broken --fix-missing --assume-yes --force-yes

add gimp inkscape

# Last thing
echo 'Installation complete. Doing final repository update and local purge...'
check
update
purge
check
sudo apt autoremove -y
echo 'Done with managed packages.'

echo 'Updating APT Xapian Index...'
sudo update-apt-xapian-index --verbose --force
