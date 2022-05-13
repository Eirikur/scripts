#!/bin/bash
# I admit that basic.sh is now really a full setup# Python
# Named setup.sh on 6/9/2015
#set -x # Trace
#set -e # Exit on error
# 8 Nov 2012: This is now quantal.sh for Ubuntu 12.10 Quantal Quetzal
# 18 Apr 2013: Moved to Linux Mint 14

# Fix Apport annoying dialogsthat you can't do anything about.

# gksu gedit /etc/default/apport
# and change "enabled" from "1" to "0", then save the file.

set -e

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
alias add='sudo apt-get -yuV install --install-recommends -qq'
alias repo='yes | sudo add-apt-repository -y'
##alias getkey='sudo apt-key'
alias update='sudo apt-get -qq update' # -qq is safe here.
alias check='sudo apt-get check -qq'
alias purge='sudo apt-get autoremove -qq; sudo apt-get autoclean -qq'
alias rm='sudo apt-get -yuV remove -qq'
alias overwrite='sudo apt-get -o Dpkg::Options::="--force-overwrite" install --reinstall'

echo "Starting apt package installations..."
echo "Repairing installed software database if needed..."
sudo apt-get install --fix-broken --fix-missing --assume-yes --force-yes
echo "Getting lastest repository information..."
sudo apt update && sudo apt dist-upgrade -y

# Enable use of HTTPS. As of 30Oct2020, apt-transport-https is not standard in Mint.
sudo apt install -y \
apt-transport-https \
ca-certificates \
curl \
gnupg-agent \
software-properties-common

# Cleanup of Mint/Ubuntu default software that I do not use.
sudo apt remove -y evolution-data-server

# Development stuff that needs to exist.
add git build-essential

# Hardware wrangling support.
add hdparm hddtemp smartmontools ioping smart-notifier clonezilla hd-idle diskscan
add filelight gnome-disk-utility
add durep ncdu duc perforate di dbench agedu gpart ddpt gdmap  # Not sure about these. Untried.
add idle3-tools # Recent Western Digital drives.


# Docker Community Edition
# curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
# sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(. /etc/os-release; echo "$UBUNTU_CODENAME") stable"
# update
# sudo apt-get -y  install docker-ce docker-compose
# sudo usermod -aG docker eh

echo "Emacs..."
repo ppa:ubuntu-elisp
update
# Conflicts with a file in emacs. This just forces the install.
overwrite emacs-snapshot-common
overwrite emacs-snapshot
# Make snapshot the default Emacs
# sudo rm /usr/bin/emacs && sudo ln -s /usr/bin/emacs-snapshot /usr/bin/emacs
# sudo rm /usr/bin/emacsclient && sudo ln -s /usr/bin/emacsclient-snapshot /usr/bin/emacsclient

echo "Adding my basic software...."
add flatpak xclip htop gparted zile guake gkrellm gkrelltop gkrellmwireless gkrellweather
add thunderbird xul-ext-lightning thunderbird-gnome-support firefox chromium-browser pidgin
add libnss-myhostname openssh-server openssh-sftp-server sshfs nfs-common # Network connectivity.
add avahi-daemon avahi-dnsconfd avahi-discover avahi-utils libnss-mdns # Make local dns work.
add htop
add lrzip # More compression formats.....

# NodeJS, npm, coffeescript
# add npm
# npm install --global npm # Updating npm from the distro version is a good idea.
# npm install --global coffeescript # Provides the REPL and compiler via the coffee command.

# Python
sudo add-apt-repository -y ppa:deadsnakes/ppa
sudo apt update && sudo apt install -y python3.10
add python3-pip bpython3 pylint python3-mypy python3-mypy-extensions
sudo pip3 install --upgrade pip # Get the latest pip.




# Filesystems, dedupe and repair thereof. # Repo commonly does not support latest releases of OS
# sudo add-apt-repository -y ppa:dupeguru/ppa
# sudo apt-get update
# add dupeguru

mkdir -p ~/scripts/
cd ~/scripts
wget https://raw.githubusercontent.com/Drewsif/PiShrink/master/pishrink.sh
chmod +x pishrink.sh
cd


# Package mgmt stuff.
add apt-xapian-index synaptic # Enable quick search in Synaptic

echo "Adding performance tools..."
add iozone3 iperf



# File managers
add nnn # TUI file manager

# File manager integrations
add nemo-terminal

# Monitoring
add iftop
echo "Nutty network monitoring..."
sudo apt-add-repository -y ppa:bablu-boy/nutty
sudo apt-get update
sudo apt-get install nutty


echo "Function-key user interface stuff..."
add wmctrl xdotool autokey-gtk numlockx # control window manager via scripts.

echo "Installing gkrellm helpers..."
sudo ~/Customization/gkrellm/install.sh



# Fix broken Cinnamon Settings (Yikes, this reset my panels.  Not good!)
# gsettings reset-recursively org.cinnamon


#### Backup system configuration
# Same code as in b.sh, but needs to be available if this file is all we have.
path="$HOME/Configuration/System"
bkp=`dirname $path`/`basename $path`
pkgs="$bkp/apt"
mkdir -p "$pkgs" -v # Creates tree as needed.
dpkg --get-selections > "$pkgs"/Package.list
sudo cp -R /etc/apt/sources.list* "$pkgs"/
sudo apt-key exportall > "$pkgs"/Repo.keys &>/dev/null

sudo apt install -y apt-clone -qq  &>/dev/null
clone="$pkgs/apt-clone"
mkdir -p "$clone"
apt-clone clone "$clone/my-mint" &>/dev/null
cd "$clone" && tar -xf "my-mint.apt-clone.tar.gz" && cd - &>/dev/null
sudo cp -raux /etc "$path"
sudo chown -R "$USER:$USER" "$path"






# Last thing
echo 'Installation complete. Doing final repository update and local purge...'
check
update
purge
check
sudo apt autoremove -y
echo 'Done with managed packages.'
echo '    Enabling X-server ctrl-alt-backspace.'
setxkbmap -option terminate:ctrl_alt_bksp
echo 'Updating APT Xapian Index...'
sudo update-apt-xapian-index --verbose --force

#sudo pip3 install --upgrade pipenv
