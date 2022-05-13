#!/bin/bash
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

echo "Bringing the installed system up-to-date with the repository..."
update
sudo apt-get dist-upgrade --assume-yes --force-yes
check
purge

# Stuff that is needed before we can really get going here.
add launchpad-getkeys  # Mint doesn't have this but somehow Mint Updater does something....

echo "Setting Startup Applications to actually show all Startup Applications..."
sudo sed -i 's/NoDisplay=true/NoDisplay=false/g' /etc/xdg/autostart/*.desktop

echo ""
echo "Installing Mint packages for my commonly used tools..."
add gnome-control-center linux-tools-common
echo "Added gnome-control-center"

add build-essential build-dep automake autoconf libtool pkg-config intltool # 11/20/2013 needed to build Terminology
add synaptic gdebi gdebi-core build-essential linux-kernel-headers
add libgtk2.0-dev libglib2.0-dev # Generally for building from source.  gkrellm-multiping, in particular
add chromium-browser
add flashplugin-installer
add testdisk smartmontools  # testdisk includes photo-rec undelete/file recovery program
add openssh-server sshfs openssh-blacklist openssh-blacklist-extra
# add openconnect # Cisco VPN client for Veteran's United
add gufw # GUI firewall config.
add system-config-samba
add rssh openssl-blacklist openssl-blacklist-extra encfs guake
add xnest gnome-rdp xclip # x in a window, and Windows remote desktop and xclip.
add gparted menu ntfs-config
add curl gftp curlftpfs filezilla filezilla-common transmission-cli traceroute
add subversion git-core meld # svn, git, meld GUI diff
add markdown
add dmidecode # very useful for listing motherboard hardware
add htop

# X Window System
add libxmu-dev

# Building Emacs from scratch requires these libs:
# add libxpm-dev libjpeg-dev libgif-dev libtiff5-dev
sudo apt-get build-dep emacs24 # Maybe this is enough


# Then, for emacs-snapshot:
# $ sudo apt-get install emacs-snapshot-el emacs-snapshot-gtk emacs-snapshot
add emacs-snapshot-el emacs-snapshot-gtk emacs-snapshot
# *Or*, for emacs24:
# $ sudo apt-get install emacs24 emacs24-el emacs24-common-non-dfsg
#  More info: https://launchpad.net/~cassou/+archive/emacs
add emacs-goodies-el zile

repo ppa:webupd8team/atom # Fully-customizable text editor from Github
update
add atom

# Configuration editors, missing in std. Mint install.
add gconf-editor dconf-tools

# Natural language tools
add gnome-dictionary wordnet-gui goldendict goldendict-wordnet

add gnumeric # For trade calculator.  Smaller than LibreOffice.
add thunderbird thunderbird-gnome-support
# add libgtk2.0-dev libgnome2-dev # For compiling Gnome apps.
add mono-gmcs mono-dmcs # For compiling Tomboy.  Packages in distros are out of date! 10/22/13

# Music Listening
sudo pip install youtube-dl --upgrade # Grabs youtube videos to get the audio album.


add audacity audacious radiotray #  radiotray # sound editor, music player, simple internet radio
add pianobar # command line Pandora client

# Monitoring Stuff
add gkrellm gkrellm-ibam gkrelltop gkrellmwireless gkrellweather
add gkrellm-x86info # not found in 10.10 Maverick amd64 repo?
add lm-sensors libnotify-bin
add conky # Latest snazzy visual monitoring program
repo ppa:teejee2008/ppa # Conky Manager
update
add conky-manager


# Network Monitoring
add etherape wireshark wavemon libpcap-dev whois
# repo ppa:wseverin/ppa/ubuntu # ;;;;;;;;;;;;;;;;;;;; Get LinSSID deb from sourceforge.


# add gespeaker mbrola gnome-voice-control
# CoffeeScript is a Ruby-like language, compiling to Javascript.
# It requires node.js
add libssl-dev pkg-config # node.js Javascript lib build requirements
add libreadline-dev # This wasn't the coffee REPL issue, but it is good to have.
repo ppa:chris-lea/node.js  # Latest node, and I don't have to compile it.
update
add nodejs
sudo npm install --global coffee-script

# Ruby.  rubygems will pull it in.
add rubygems irb


# Python
add python-distutils
add python-distutils-extra
add bpython bpython3
add pep8 pylint pyflakes
add python-pip python3-pip # Add other PyPi items here.
add python-dev # Required in order to build Python extenstion for Monner.
sudo pip install monner --upgrade # Outstanding process runner that shows process stats.
sudo pip install batinfo pysensors # Required for glances, just below
sudo pip install glances --upgrade # Outstanding system monitor program like a systat. Curses.

# For my powermate.py
add python-notify2 python3-notify2

#add python-virtkey # Use with Powermate to control volume
# Python 3 Time to start building my list of P3 needs.
#add python3-virtkey


# Development Tools (my extensions to build-essential basically) 9/16/2013
add cmake
add libboost-all-dev # Libboost is a dev thing if you are compiling an app.

add gsfonts gsfonts-x11 fonts-inconsolata t1utils xfonts-jmk edubuntu-fonts
add font-manger fontypython fontforge python-fontforge gnome-specimen fontmatrix gnome-font-viewer gwaterfall
# add fondu # set of programs to convert between Mac (resource fork) and Unix formats
add fonts-inconsolata

# Image processing and Drawing
add xpdf inkscape gimp gthumb # electricsheep # electricsheep screensaver
repo ppa:otto-kesselgulasch/gimp # for gmic, gets stable GIMP updates, too.
update
add gmic gimp-gmic

add compizconfig-settings-manager compiz-plugins # Compiz settings, plugins+
add fslint bleachbit # Clean up filesystems.
add tomboy # I use this and use the sync feature.
# repo ppa:cooperjona/nitrotasks
# update
# add nitrotasks

# Archive and compression format support
# I used to install lha but there's no candidate????
add unace rar unrar zip unzip p7zip-full p7zip-rar sharutils uudeview mpack arj cabextract file-roller
add alien # convert rpm/deb formats
add acetoneiso
#add # xsblinkd # blink the keyboard leds from scripts.
#add # preload # Loads your commonly used programs into memory at boot time.

#### Not working.  Find out why.  FIXME
# grub customizer can even boot from ISO images!
repo ppa:danielrichter2007/grub-customizer
update
add grub-customizer

# Keyboard and mouse:
add xkeycaps xbindkeys xbindkeys-config xvkbd

add wmctrl # control window manager via scripts.
repo ppa:cdekter/ppa/ubuntu
add autokey-gtk
# Productivity
repo ppa:libreoffice/ppa
update
add libreoffice libreoffice-gnome

# I hate Java, but I need to have it.
# Java 7 is the latest.  Thank you to Andrew.
repo ppa:webupd8team/java # ThinkOrSwim is a Java app.  Remember to like Java a bit for that.
update
add oracle-java7-installer

# Crypto and Security
add scrypt


# Music stuff. Start
# add uuid uuid-dev
# repo ppa:frasten/ppa
# add ardour3
#repo ubuntu-wine/ppa/ubuntu
#add wine
# repo ppa:racb/extra/ubuntu
# update
# add pianobooster

repo ppa:webupd8team/y-ppa-manager
add yad y-ppa-manager ppa-purge

# webupd8.org's collection of themes.
repo ppa:nilarimogard/webupd8
# repo ppa:gezakovacs/ppa # Not in quetzal yet.
add unetbootin

# Like Tortoise-svn.  Really neat.
# repo ppa:rabbitvcs/ppa
# add rabbitvcs-core rabbitvcs-nautilus rabbitvcs-nautilus3 rabbitvcs-gedit rabbitvcs-cli
# repo ppa:rabbitvcs/ppa
add python-nemo nemo-rabbitvcs rabbitvcs-cli rabbitvcs-gedit

# repo ppa:pmjdebruijn/darktable-unstable/ubuntu
# add darktable

repo ppa:transmissionbt/ppa
add transmission-gtk transmission-cli

# Macintosh Classic    # Doesn't have anything for quantal, seems defunct Nov 25, 2012
# repo ppa:mdeslaur/ppa
# update
# add sheepshaver

# Last thing
echo 'Installation complete. Doing final repository update and local purge...'
check
update
purge
check
echo 'Done with managed packages.'
echo 'Updating APT Xapian Index...'
sudo update-apt-xapian-index
echo '    Enabling X-server ctrl-alt-backspace.'
setxkbmap -option terminate:ctrl_alt_bksp
echo ''
echo 'Setting gconf options:'
#echo '    Emacs keybindings for GNOME dialogs.'
#gconftool-2 --type string --set /desktop/gnome/interface/gtk_key_theme Emacs
echo '    Enabling icons in menus...'
gconftool-2 --set /desktop/gnome/interface/menus_have_icons --type boolean True
echo '    Disabling Logout/Restart/Shutdown confirmation dialog...'
gconftool-2 –type bool –set /apps/indicator-session/suppress_logout_restart_shutdown true
echo '    Enable changing accelerator keys in GNOME menus.'
gsettings set org.gnome.desktop.interface can-change-accels true
echo 'Setting Workspaces to 1.'
gsettings set org.cinnamon number-workspaces 1
echo 'Done!'
