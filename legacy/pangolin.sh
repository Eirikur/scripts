#!/bin/bash
#set -x # Trace
#set -e # Exit on error

# Fix Apport annoying dialogs that you can't do anything about.
# gksu gedit /etc/default/apport
# and change "enabled" from "1" to "0", then save the file.





shopt -s expand_aliases

echo 'Defining commands...' # install-suggests is evil and installs a TON of stuff I don't want!!!!
alias add='sudo apt-get -yuV install --install-recommends -qq'
alias repo='sudo add-apt-repository --yes'
##alias getkey='sudo apt-key'
alias update='sudo apt-get -qq update' # -qq is safe here.
alias check='sudo apt-get check -qq'
alias purge='sudo apt-get autoremove -qq; sudo apt-get autoclean -qq'
alias rm='sudo apt-get -yuV remove -qq'

echo "Fixing the package database if needed..."
sudo apt-get install --fix-broken --fix-missing --assume-yes --force-yes

echo "Bringing the installed system up-to-date with the repository..." 
update
sudo apt-get dist-upgrade --assume-yes --force-yes
check
purge

echo "Adding my desktop environment: gnome-session-fallback..."
# 8 Nov 2012: This is going away soon.  Move to GNOME-shell with autohide plugin.
add gnome-session-fallback gnome-shell
# 8 Nov 2012: Let's get started with GNOME 3
add ubuntu-gnome-desktop ubuntu-gnome-default-settings
sudo apt-get remove ubuntu-settings # Andrew of webupd8 says do this.
sudo add gnome-documents gnome-boxes
repo ppa:gnome3-team/gnome3
# The packages that will be upgraded once you add the PPA are: Aisleriot
# 3.6.0, Brasero 3.6.0, Nautilus 3.6.1 and Totem 3.6.0. The PPA also
# provides Transmission 0.7.1, Transmageddon 0.23 and Sound Juicer
# 3.5.0.
repo ppa:webupd8team/gnome3
update
add gnome-shell-extensions-autohidetopbar # From Andrew's repo.
sudo apt-get remove overlay-scrollbar* # Yeah, Baby, yeah!

echo "Setting Startup Applications to actually show all Startup Applications..."
sudo sed -i 's/NoDisplay=true/NoDisplay=false/g' /etc/xdg/autostart/*.desktop
echo "Adding unsettings, Ubuntu-Tweak, Jupiter..."
repo ppa:diesch/testing # Unsettings
repo ppa:tualatrix/ppa # Ubuntu-Tweak
repo ppa:webupd8team/jupiter # Laptop and screen orientation indicator/control
repo ppa:marlin-devs/marlin-daily
update
add marlin
add unsettings
add ubuntu-tweak --force-yes
add jupiter
# repo ppa:~flozz/+archive/flozz
# add nautilus-terminal

# echo "Adding zramswap-enabler"
# repo ppa:shnatsel/zram
# update
# add zramswap-enabler



echo ""
echo "Installing Ubuntu packages for my commonly used tools..."
add synaptic gdebi gdebi-core build-essential linux-kernel-headers
add libgtk2.0-dev libglib2.0-dev # Generally for building from source.  gkrellm-multiping, in particular
add chromium-browser
add testdisk # includes photo-rec undelete/file recovery program
add openssh-server sshfs openssh-blacklist openssh-blacklist-extra
add rssh openssl-blacklist openssl-blacklist-extra encfs guake
add xnest gnome-rdp xclip # x in a window, and Windows remote desktop and xclip.
add gparted ntfsprogs menu ntfs-config
add curl gftp curlftpfs filezilla filezilla-common transmission-cli traceroute
add subversion git-core meld # svn, git, meld GUI diff
add emacs emacs-goodies-el zile # for E24 I'm trying the snapshot
add nautlius-python # required for nautlius-terminal
add dmidecode # very useful for listing motherboard hardware


add gnumeric # For trade calculator.  Smaller than LibreOffice.
#add thunderbird thunderbird-gnome-support
# add libgtk2.0-dev libgnome2-dev # For compiling Gnome apps.
add audacity audacious radiotray #  radiotray # sound editor, music player, simple internet radio
add pianobar # command line Pandora client
repo ppa:kevin-mehall/pithos-daily # Use the PPA because Pandora changes the protocol.
update
add pithos
add gkrellm gkrellm-ibam gkrelltop gkrellmwireless gkrellweather
add gkrellm-x86info # not found in 10.10 Maverick amd64 repo?
add lm-sensors libnotify-bin
add etherape wireshark wavemon libpcap-dev
# add gespeaker mbrola gnome-voice-control
# CoffeeScript is a Ruby-like language, compiling to Javascript.
# It requires node.js, which is like Python's twisted.
add libssl-dev pkg-config # node.js Javascript lib build requirements
add libreadline-dev # This wasn't the coffee REPL issue, but it is good to have.
# Ruby.  rubygems will pull it in.
add rubygems irb
# Python
add ipython ipython-qtconsole
add python-pip # Add other PyPi items here.
add python-dev # Required in order to build Python extenstion for Monner.
sudo pip install monner # Outstanding process runner that shows process stats.
sudo pip install glances # Outstanding system monitor program like a systat. Curses.
# add screenlets
add gsfonts gsfonts-x11 ttf-inconsolata t1utils flashplugin-nonfree
add xpdf inkscape gimp gthumb # electricsheep # electricsheep screensaver 
add compizconfig-settings-manager compiz-plugins # Compiz settings, plugins+
add fslint bleachbit # Clean up filesystems.
add tomboy # I use this and use the sync feature.
add htop 
# Archive and compression format support
add unace rar unrar zip unzip p7zip-full p7zip-rar sharutils uudeview mpack lha arj cabextract file-roller
add alien # convert rpm/deb formats
add acetoneiso
#add # xsblinkd # blink the keyboard leds from scripts.
#add # preload # Loads your commonly used programs into memory at boot time.

add bum # boot up manager: startup service managment.

# grub customizer can even boot from ISO images!
repo ppa:danielrichter2007/grub-customizer
update
add grub-customizer

# Keyboard and mouse:
add xkeycaps xbindkeys xbindkeys-config xvkbd
add bluez-compat # Pangolin for Apple Wireless Trackpad
add wmctrl # control window manager via scripts.

# Productivity
repo ppa:atareao/atareao # calendar-indicator
repo ppa:libreoffice/ppa
update
add calendar-indicator
add libreoffice libreoffice-gnome

# I hate Java, but I need to have it.
# Java 7 is the latest.  Thank you to Andrew.
repo ppa:webupd8team/java # ThinkOrSwim is a Java app.  Remember to like Java a bit for that.
update
add oracle-java7-installer


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
repo ppa:rabbitvcs/ppa
add rabbitvcs-core rabbitvcs-nautilus rabbitvcs-gedit rabbitvcs-cli


# repo ppa:pmjdebruijn/darktable-unstable/ubuntu
# add darktable
    
repo ppa:transmissionbt/ppa 
add transmission-gtk transmission-cli


add launchpad-getkeys

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
echo '    Disabling overlay scrollbars...'
echo "export LIBOVERLAY_SCROLLBAR=0" > /etc/X11/Xsession.d/80overlayscrollbars
sudo apt-get remove overlay-scrollbar liboverlay-scrollbar-0.2-0 liboverlay-scrollbar3-0.2-0
echo '    Enable changing accelerator keys in GNOME menus.'
gsettings set org.gnome.desktop.interface can-change-accels true
echo 'Done!'
