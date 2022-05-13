#!/bin/bash
# Named setup.sh on 6/9/2015
# set -x # Trace
set -e # Exit on error
# 8 Nov 2012: This is now quantal.sh for Ubuntu 12.10 Quantal Quetzal
# 18 Apr 2013: Moved to Linux Mint 14

# Fix Apport annoying dialogs that you can't do anything about.

# gksu gedit /etc/default/apport
# and change "enabled" from "1" to "0", then save the file.

# Tell BASH to expand aliases."
sudo mkdir -p /usr/local/share/gkrellm
sudo cp -v ~/Customization/GrabWeather/GrabWeather /usr/local/share/gkrellm/GrabWeather
add gkrellm-x86info # not found in 10.10 Maverick amd64 repo?
add lm-sensors libnotify-bin
add conky # Latest snazzy visual monitoring program
repo ppa:teejee2008/ppa # Conky Manager
update
add conky-manager


# Network Monitoring
add etherape wireshark wavemon libpcap-dev whois nethogs
# repo ppa:wseverin/ppa/ubuntu # ;;;;;;;;;;;;;;;;;;;; Get LinSSID deb from sourceforge.


# add gespeaker mbrola gnome-voice-control
# CoffeeScript is a Ruby-like language, compiling to Javascript.
# It requires node.js
# add libssl-dev pkg-config # node.js Javascript lib build requirements
# add libreadline-dev # This wasn't the coffee REPL issue, but it is good to have.
# repo ppa:chris-lea/node.js  # Latest node, and I don't have to compile it.
# update
# add nodejs
# sudo npm install --global coffee-script

# Ruby.  rubygems will pull it in.
# add rubygems irb

# perl
# add libcurses-perl
# add libcurses-widgets-per
# add libcurses-ui-perl
# # Perl's CPAN repo
# sudo cpan App::cpanminus
# # For asciquarium
# sudo cpanm Term::Animation



# Python
add python-distutils
add python-distutils-extra
add bpython bpython3
add pep8 pylint pyflakes
add python-pip python3-pip # Add other PyPi items here.
add python-dev # Required in order to build Python extenstion for Monner.
update
sudo pip install monner --upgrade # Outstanding process runner that shows process stats.
sudo pip install batinfo pysensors # Required for glances, just below
sudo pip install glances --upgrade # Outstanding system monitor program like a systat. Curses.
sudo pip install netifaces --upgrade # Get most recent to fix glances.  Mint's is too old.
sudo pip install youtube-dl --upgrade # Grabs youtube videos to get the audio album.
sudo pip install s-tui --upgrade # s-tui console-based resource monitor (graphical)

# Midi
add libportmidi0 libportmidi-dev librtmidi1 librtmidi-dev midisnoop
sudo pip3 install mido





# For my powermate.py
add python3-notify2

#add python-virtkey # Use with Powermate to control volume
# Python 3 Time to start building my list of P3 needs.
#add python3-virtkey


# Development Tools (my extensions to build-essential basically) 9/16/2013
add cmake
# add libboost-all-dev # Libboost is a dev thing if you are compiling an app.

# Fonts Fonts Fonts
add font-manager fontypython fontmatrix fontforge python-fontforge gnome-specimen fontmatrix gnome-font-viewer gwaterfall
# add fondu # set of programs to convert between Mac (resource fork) and Unix formats
add fonts-inconsolata
add ttf-mscorefonts-installer

# Image processing and Drawing
add xpdf inkscape gimp gthumb # electricsheep # electricsheep screensaver
repo ppa:otto-kesselgulasch/gimp # for gmic, gets stable GIMP updates, too.
update
add gmic gimp-gmic

#add compizconfig-settings-manager compiz-plugins # Compiz settings, plugins+
add fslint bleachbit # Clean up filesystems.
add tomboy-ng # I use this and use the sync feature.
# repo ppa:cooperjona/nitrotasks
# update
# add nitrotasks

# Archive and compression format support
# I used to install lha but there's no candidate????
add unace rar unrar zip unzip p7zip-full p7zip-rar sharutils uudeview mpack arj cabextract file-roller lrzip
add alien # convert rpm/deb formats
add acetoneiso
add numlockx
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
add xdotool

# Productivity
repo ppa:libreoffice/ppa # This is the LibreOffice Fresh PPA
update
add libreoffice libreoffice-gnome

# Balena etcher for Raspberry Pi cards and possible other things.
echo "deb https://deb.etcher.io stable etcher" | sudo tee /etc/apt/sources.list.d/balena-etcher.list
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 379CE192D401AB61
update
add etcher-electron


# I hate Java, but I need to have it.
# Java 7 is the latest.  Thank you to Andrew.
## Disabled 1/8/17 because of brokeness
# echo "Java 7..."
# repo ppa:webupd8team/java # ThinkOrSwim is a Java app.  Remember to like Java a bit for that.
# update
# add oracle-java7-installer

# Java 8
# sudo add-apt-repository -y ppa:webupd8team/java
# update
# sudo apt-get install -y oracle-java8-installer
# sudo apt-get install -y oracle-java8-set-default
# Java 12
# sudo add-apt-repository ppa:linuxuprising/java
# sudo apt update
# sudo apt install oracle-java12-installer


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
add cheese

# For building linuxsampler, where we need the bleeding edge
add libsndfile1-dev mcp-plugins swh-plugins fomp tap-plugins rev-plugins swami

# Electronic schematics and board layout
add fritzing fritzing-parts



# repo ppa:webupd8team/y-ppa-manager
# add yad y-ppa-manager ppa-purge

# webupd8.org's collection of themes.
# repo ppa:nilarimogard/webupd8
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


# Last thing
sudo apt autoremove
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
echo '    Emacs keybindings for GNOME dialogs.'
gconftool-2 --type string --set /desktop/gnome/interface/gtk_key_theme Emacs
echo '    Enabling icons in menus...'
gconftool-2 --set /desktop/gnome/interface/menus_have_icons --type boolean True
echo '    Disabling Logout/Restart/Shutdown confirmation dialog...'
gconftool-2 –type bool –set /apps/indicator-session/suppress_logout_restart_shutdown true
echo '    Enable changing accelerator keys in GNOME menus.'
gsettings set org.gnome.desktop.interface can-change-accels true
echo 'Setting Workspaces to 1.'
gsettings set org.cinnamon number-workspaces 1
echo 'Done!'

