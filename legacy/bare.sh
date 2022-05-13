#!/bin/bash
# Named setup.sh on 6/9/2015
#set -x # Trace
#set -e # Exit on error
# 8 Nov 2012: This is now quantal.sh for Ubuntu 12.10 Quantal Quetzal
# 18 Apr 2013: Moved to Linux Mint 14

# Fix Apport annoying dialogsthat you can't do anything about.

# gksu gedit /etc/default/apport
# and change "enabled" from "1" to "0", then save the file.

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

# Eliminate the need to type .local all the time.
# echo "CannonicalizeHostnames to eliminate .local..."
# echo "Host *
#   CanonicalDomains local
#   CanonicalizeHostname yes
# " > ~/.ssh/config



# echo 'Configuring loop devices...'
# sudo echo 'options loop max_part=31' | sudo tee -a /etc/modprobe.d/loop_device.conf


echo "Defining installation commands..."
# install-suggests is evil and installs a TON of stuff I don't want!!!!
alias add='sudo apt -yuV install --install-recommends -qq'
alias repo='yes | sudo add-apt-repository -y'
##alias getkey='sudo apt-key'
alias update='sudo apt -qq update' # -qq is safe here.
alias check='sudo apt check -qq'
alias purge='sudo apt autoremove -qq -y; sudo apt autoclean -qq -y'
alias rm='sudo apt -yuV remove -qq'

echo "Fix package system if partial installations are detected..."
sudo dpkg --configure -a
echo "Starting apt package installations..."
echo "Repairing installed software database if needed..."
sudo apt install --fix-broken --fix-missing --assume-yes 
echo "Getting lastest repository information..."
sudo apt update && sudo apt dist-upgrade -y

# Enable use of HTTPS. As of 30Oct2020, apt-transport-https is not standard in Mint.
sudo apt install -y \
apt-transport-https \
ca-certificates \
curl \
gnupg-agent \
software-properties-common


# Docker Community Edition
# curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
# sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(. /etc/os-release; echo "$UBUNTU_CODENAME") stable"
# update
# sudo apt -y  install docker-ce docker-compose
# sudo usermod -aG docker eh

echo "Emacs..."
repo ppa:ubuntu-elisp
update
add emacs-snapshot
# Make snapshot the default Emacs
sudo rm /usr/bin/emacs && sudo ln -s /usr/bin/emacs-snapshot /usr/bin/emacs
# Tell systemd about the emacs service
# sudo systemctl enable emacs.service
# sudo systemctl start emacs

echo "Adding basic software...."
add gparted zile guake gkrellm gkrellm gkrelltop gkrellmwireless gkrellweather
add libnss-myhostname openssh-server openssh-sftp-server sshfs nfs-common # Network connectivity.
add avahi-daemon avahi-dnsconfd avahi-discover avahi-utils libnss-mdns # Make local dns work.

# Filesystems, dedupe and repair thereof.


add dtrx # CLI tools

# Package mgmt stuff.
add apt-xapian-index synaptic # Enable quick search in Synaptic

echo "Adding performance tools..."
add iozone3

add python3-pip python-pip
sudo pip3 install --upgrade pip # Get the latest pip.
sudo pip3 install --upgrade pipenv

sudo pip3 install glances

# Monitoring
add iftop iotop

echo "Function-key user interface stuff..."
add wmctrl xdotool autokey-gtk numlockx # control window manager via scripts.

echo "Installing gkrellm and helpers..."
add gkrellm 
sudo ~/Customizations/gkrellm/install.sh
add gkrellm gkrellm-ibam gkrelltop gkrellmwireless gkrellweather
echo "sudo cp -v ~/Customizations/GrabWeather /usr/share/gkrellm/GrabWeather"
sudo cp -v ~/Customizations/GrabWeather /usr/share/gkrellm/GrabWeather



# Last thing
echo 'Installation complete. Doing final repository update and local purge...'
check
update
purge
check
echo 'Done with managed packages.'
echo '    Enabling X-server ctrl-alt-backspace.'
setxkbmap -option terminate:ctrl_alt_bksp
echo 'Updating APT Xapian Index...'
sudo update-apt-xapian-index --verbose --force
