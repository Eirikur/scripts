#!/bin/bash
# Named setup.sh on 6/9/2015
#set -x # Trace
#set -e # Exit on error
# 8 Nov 2012: This is now quantal.sh for Ubuntu 12.10 Quantal Quetzal
# 18 Apr 2013: Moved to Linux Mint 14

# Fix Apport annoying dialogs that you can't do anything about.

# gksu gedit /etc/default/apport
# and change "enabled" from "1" to "0", then save the file.

# Tell BASH to expand aliases.
shopt -s expand_aliases

echo 'Enabling sudo'
sudo adduser eh sudo
sudo echo 'eh  ALL=(ALL) NOPASSWD:ALL' | sudo tee -a /etc/sudoers.d/eh # tee hack avoids IO redirect which does not work.
echo 'Done with sudo enablement."

echo 'Defining commands...'
# install-suggests is evil and installs a TON of stuff I don't want!!!!
alias add='sudo apt-get -yuV install --install-recommends -qq'
alias repo='yes | sudo add-apt-repository -y'
##alias getkey='sudo apt-key'
alias update='sudo apt-get -qq update' # -qq is safe here.
alias check='sudo apt-get check -qq'
alias purge='sudo apt-get autoremove -qq; sudo apt-get autoclean -qq'
alias rm='sudo apt-get -yuV remove -qq'
sudo apt-get install --fix-broken --fix-missing --assume-yes --force-yes




# I hate Java, but I need to have it.
# Java 7 is the latest.  Thank you to Andrew.
echo "Java 7..."
repo ppa:webupd8team/java # ThinkOrSwim is a Java app.  Remember to like Java a bit for that.
update
add oracle-java7-installer
