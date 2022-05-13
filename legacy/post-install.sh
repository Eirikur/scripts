#!/bin/bash
# set -x # Trace
set -e # Exit on error
# 8 Nov 2012: This is now quantal.sh for Ubuntu 12.10 Quantal Quetzal
# 18 Apr 2013: Moved to Linux Mint 14

# Fix Apport annoying dialogs that you can't do anything about.
# gksu gedit /etc/default/apport
# and change "enabled" from "1" to "0", then save the file.

shopt -s expand_aliases

sudo adduser eh sudo

echo 'Defining commands...' # install-suggests is evil and installs a TON of stuff I don't want!!!!
alias add='sudo apt-get -yuV install --install-recommends -qq'
alias repo='sudo add-apt-repository --yes'
##alias getkey='sudo apt-key'
alias update='sudo apt-get -qq update' # -qq is safe here.
alias check='sudo apt-get check -qq'
alias purge='sudo apt-get autoremove -qq; sudo apt-get autoclean -qq'
alias rm='sudo apt-get -yuV remove -qq'
add launchpad-getkeys # Do this early in case we need it later.

echo "Fixing the package database if needed..."
sudo apt-get install --fix-broken --fix-missing --assume-yes --force-yes
echo "    Done."
echo "Bringing the installed system up-to-date with the repository..."
echo "    Updating package indexes..."
update
echo "    Done."
echo "    Updating packages that need updating..."
sudo apt-get dist-upgrade --assume-yes --force-yes
echo "    Done."
echo "Checking the database for broken dependencies..."
check
echo "    Done."

echo "Adding all my repositories..."
# repo  ppa:elementary-os/daily
repo ppa:atareao/atareao # calendar-indicator
repo ppa:cooperjona/nitrotasks
repo ppa:danielrichter2007/grub-customizer
repo ppa:libreoffice/ppa
repo ppa:mdeslaur/ppa
repo ppa:nilarimogard/webupd8
repo ppa:rabbitvcs/ppa
repo ppa:racb/extra/ubuntu
repo ppa:transmissionbt/ppa
repo ppa:webupd8team/java # ThinkOrSwim is a Java app.  Remember to like Java a bit for that.
repo ppa:webupd8team/y-ppa-manager
echo "   Done adding repositories."
echo "Updating package index files from repositories."
update
echo "    Done updating package index files."
echo "Setting Startup Applications to actually show all Startup Applications..."
sudo sed -i 's/NoDisplay=true/NoDisplay=false/g' /etc/xdg/autostart/*.desktop

echo ""
echo "Installing Mint packages for my commonly used tools..."

# Base system
add build-essential linux-kernel-headers
add libgtk2.0-dev libglib2.0-dev # Generally for building from source.  gkrellm-multiping, in particular

# Displays
add compizconfig-settings-manager compiz-plugins # Compiz settings, plugins+
add xnest gnome-rdp xclip # x in a window, and Windows remote desktop and xclip.

# Keyboard and mouse:
add xkeycaps xbindkeys xbindkeys-config xvkbd
add bluez-compat # Pangolin for Apple Wireless Trackpad
add wmctrl # control window manager via scripts.
add autokey-gtk # autokey-qt

# Package Management
add synaptic gdebi gdebi-core
add yad y-ppa-manager ppa-purge

# System monitoring
add dmidecode # very useful for listing motherboard hardware
add htop

# Boot management
add grub-customizer # grub customizer can even boot from ISO images!

# Storage management
add gparted ntfsprogs menu ntfs-config
add unetbootin
add testdisk # includes photo-rec undelete/file recovery program
add fslint bleachbit # Clean up filesystems.

# Archive and compression format support
add unace rar unrar zip unzip p7zip-full p7zip-rar sharutils uudeview mpack lha arj cabextract file-roller
add alien # convert rpm/deb formats

# Desktop goodies
add jupiter # Video and power and speedstep settings in tray.
add radiotray # Internet radio in desktop tray
add lm-sensors libnotify-bin # For gkrellm, conky, etc.
add gkrellm gkrellm-ibam gkrelltop gkrellmwireless gkrellweather
add gkrellm-x86info
add guake # Terminal
add calendar-indicator

# Note-takes and list-making
add tomboy # I use this and use the sync feature.
add nitrotasks

# Desktop Applications
add gnumeric # For trade calculator.  Smaller than LibreOffice.
add audacity audacious # sound editor, music player
add pianobar # command line Pandora client
add xpdf inkscape gimp gthumb # electricsheep # electricsheep screensaver
add libreoffice libreoffice-gnome

# Programming
add subversion git-core meld # svn, git, meld GUI diff
add emacs emacs-goodies-el zile # for E24 I'm trying the snapshot
add markdown

# Runtimes
# Java 7 is the latest.  Thank you to Andrew.
add oracle-java7-installer  # ThinkOrSwim runtime

# Web browsers
# add flashplugin-nonfree # Not in Mint 14
add firefox chromium-browser

# Email
add thunderbird thunderbird-gnome-support

# Network tools
add openssh-server sshfs openssh-blacklist openssh-blacklist-extra
add rssh openssl-blacklist openssl-blacklist-extra encfs
add etherape wireshark wavemon libpcap-dev
add system-config-samba
add curl gftp curlftpfs filezilla filezilla-common traceroute
add transmission-gtk

# Programming Languages
# CoffeeScript is a Ruby-like language, compiling to Javascript.
# It requires node.js, which is like Python's twisted.
add libssl-dev pkg-config # node.js Javascript lib build requirements
add libreadline-dev # This wasn't the coffee REPL issue, but it is good to have.
# Ruby.  rubygems will pull it in.
add rubygems irb
# Python
# add python-distutils # Not in Mint 14 repositories.
add python-distutils-extra
add bpython
add pep8 pylint pyflakes
add python-pip # Add other PyPi items here.
add python-dev # Required in order to build Python extenstion for Monner.
sudo pip install monner --upgrade # Outstanding process runner that shows process stats.
sudo pip install glances --upgrade # Outstanding system monitor program like a systat. Curses.
sudo pip install pysdm --upgrade # GUI interface to fstab

# Fonts
add gsfonts gsfonts-x11 ttf-inconsolata t1utils xfonts-jmk edubuntu-fonts
# font-manger Not in Mint 14
add fontypython fontforge python-fontforge gnome-specimen fontmatrix gnome-font-viewer gwaterfall
add fondu # set of programs to convert between Mac (resource fork) and Unix formats

# Last thing
echo 'Installation complete. Performing package list check...'
check

echo '    Done with managed packages.'
echo 'Updating APT Xapian Index...'
sudo update-apt-xapian-index
echo 'Enabling X-server ctrl-alt-backspace.'
setxkbmap -option terminate:ctrl_alt_bksp
echo ''
echo 'Setting gconf options:'
echo '    Enabling icons in menus...'
gconftool-2 --set /desktop/gnome/interface/menus_have_icons --type boolean True
echo '    Disabling Logout/Restart/Shutdown confirmation dialog...'
gconftool-2 –type bool –set /apps/indicator-session/suppress_logout_restart_shutdown true
echo '    Enable changing accelerator keys in GNOME menus.'
gsettings set org.gnome.desktop.interface can-change-accels true
echo 'Setting Workspaces to 1.'
gsettings set org.cinnamon number-workspaces 1
echo 'Done!'
