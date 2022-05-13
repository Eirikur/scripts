#!/bin/bash
#set -x # Trace
#set -e # Exit on error

shopt -s expand_aliases
SERVER='natasha'

# if [ -a ~/Desktop/Natasha ]; then
#     echo "Natasha mount point ~/Desktop/Natasha exists."
# else
#     echo "Creating ~/Desktop/Natasha mount point folder..."
#     mkdir ~/Desktop/Natasha
# fi


# if ! grep -q Natasha /etc/fstab; then
#     echo "Found Natasha entry in fstab."
# else
#     echo "Appending Natasha mount information to /etc/fstab ..."
#     cp /etc/fstab /tmp
#     cp /etc/fstab ~/fstab-backup
#     echo "//192.168.1.111/Eirikur /home/eh/Natasha smbfs auto,username=eh,password=eh123eh,uid=1000,umask=000,user 0 0" >> /tmp/fstab
#     sudo mv /tmp/fstab /etc1
# fi

# echo "Doing mount -a to mount Natasha..."
# sudo mount -a
# sleep 2

# # Get my immediate emacs needs
# echo 'Getting my Emacs files...'

echo 'Defining commands...' 
alias add='sudo apt-get -yuV install --install-recommends -qq'
alias repo='sudo add-apt-repository'
##alias getkey='sudo apt-key'
alias update='sudo apt-get -qq update' # -qq is safe here.
alias check='sudo apt-get check -qq'
alias purge='sudo apt-get autoremove -qq; sudo apt-get autoclean -qq'

# Using only the freshly installed repository list
echo "Fixing the package database if needed..."
sudo apt-get install --fix-broken --fix-missing --assume-yes --force-yes

echo "Bringing the installed system up-to-date with the repository..." 
update
sudo apt-get dist-upgrade --assume-yes --force-yes
check
purge


echo ""
echo "Installing Ubuntu packages for my commonly used tools..."
add etckeeper build-essential linux-kernel-headers
add testdisk # includes photo-rec undelete/file recovery program
add openssh-server sshfs openssh-blacklist openssh-blacklist-extra
add rssh openssl-blacklist openssl-blacklist-extra encfs guake
add xnest gnome-rdp # x in a window, and Windows remote desktop. 
add gparted ntfsprogs menu ntfs-config
add gftp curlftpfs filezilla filezilla-common transmission-cli traceroute
add subversion git-core meld # svn, git, meld GUI diff
add emacs-snapshot emacs-goodies-el # for E24 I'm trying the snapshot
add thunderbird thunderbird-gnome-support
add libgtk2.0-dev libgnome2-dev # For compiling Gnome apps.
add audacity audacious #  radiotray # sound editor, music player, simple internet radio
add gkrellm gkrellm-ibam gkrelltop gkrellmwireless gkrellweather
add gkrellm-x86info # not found in 10.10 Maverick amd64 repo?
add lm-sensors sensors-applet libnotify-bin
add etherape wireshark wavemon ettercap-gtk libpcap-dev
add gespeaker mbrola gnome-voice-control
# CoffeeScript is a Ruby-like language, compiling to Javascript.
# It requires node.js, which is like Python's twisted.
add libssl-dev pkg-config # node.js Javascript lib build requirements
# Ruby.  rubygems will pull it in.
add rubygems irb
# add screenlets
add gsfonts gsfonts-x11 ttf-inconsolata t1utils flashplugin-nonfree
add xpdf inkscape gimp gthumb electricsheep # electricsheep screensaver 
add simple-ccsm compizconfig-settings-manager # Compiz settings
add compizconfig-settings-manager
add fslint bleachbit # Clean up filesystems.
add tasque gnote # My to-do list manager, and tomboy/stickies replacement.
add htop 
# Archive and compression format support
add unace rar unrar zip unzip p7zip-full p7zip-rar sharutils uudeview mpack lha arj cabextract file-roller
add alien # convert rpm/deb formats
add acetoneiso
add # xsblinkd # blink the keyboard leds from scripts.
add preload # Loads your commonly used programs into memory at boot time.
add bum # boot up manager: startup service managment.
# Keyboard and mouse:
add xkeycaps xbindkeys xbindkeys-config xvkbd
add wmctrl # control window manager via scripts.
# Java for Firefox for Moto login
add default-jre # Pulls in other java stuff.

# Music stuff. Start
# add uuid uuid-dev
# repo ppa:frasten/ppa
# add ardour3
#repo ubuntu-wine/ppa/ubuntu 
#add wine

repo ppa:diesch/testing
update
add unsettings

repo ppa:racb/extra/ubuntu
update
add pianobooster

repo ppa:webupd8team/y-ppa-manager
add yad y-ppa-manager ppa-purge

# webupd8.org's collection of themes.
repo ppa:nilarimogard/webupd8

# echo ""
# echo "Installing Ubuntu packages for my special hardware..."
# echo "Broadcom bcmwl for Linksys WPC600N dual-band N cards."
# sudo apt-get install --assume-yes --force-yes bcmwl-kernel-source 
# sudo apt-get install --assume-yes --force-yes bcmwl-modaliases

repo ppa:mozillateam/firefox-stable/ubuntu
repo ppa:mozillateam/thunderbird-stable/ubuntu
add firefox thunderbird

repo ppa:gezakovacs/ppa
add unetbootin

repoa ppa:gnome-terminator/ppa
add terminator

# Like Tortoise-svn.  Really neat.
repo ppa:rabbitvcs/ppa
add rabbitvcs-core rabbitvcs-nautilus rabbitvcs-thunar rabbitvcs-gedit rabbitvcs-cli


repo ppa:pmjdebruijn/darktable-unstable/ubuntu
add darktable

repo ppa:libreoffice/ppa
add libreoffice
    
repo ppa:transmissionbt/ppa 
add transmission-gtk transmission-cli

# repo ppa:am-monkeyd/nautilus-elementary-ppa
# Nautilus will be upgraded to elementary if "highest version"

http://archive.getdeb.net/ubuntu lucid-getdeb apps

repo ppa:danielrichter2007/grub-customizer
add grub-customizer

repo ppa:nilarimogard/webupd8 # Check out the rest of this ppa!
add launchpad-getkeys

# repo ppa:jimmyxu/hotot # What is hotot?
# add hotot

# repo ppa:bikeshed/ppa  # What is bikeshed?
# add bikeshed

# repo ppa:ailurus # What is ailurus?
# add ailurus

#repo ppa:org-mode/daily-ppa
#add org-mode

# GTG Getting things GNOME.  Task/todo manager.
# repo ppa:invernizzi/gtg-daily
# add gtg

# ubuntu-Tweak
repo ppa:tualatrix/ppa
add ubuntu-tweak --force-yes

# GetDeb
if ! grep getdeb /etc/apt/sources.list > /dev/null
    then
        echo 'Adding GetDeb repository...'
        repo 'deb http://archive.getdeb.net/ubuntu lucid-getdeb apps'
        wget -q -O- http://archive.getdeb.net/getdeb-archive.key | sudo apt-key add -
    else
        echo 'GetDeb repository already in place.'

fi
wget -q -O- http://archive.getdeb.net/getdeb-archive.key | sudo apt-key add -

# Medibuntu
echo 'Adding Medibuntu repository...'
sudo wget --output-document=/etc/apt/sources.list.d/medibuntu.list http://www.medibuntu.org/sources.list.d/$(lsb_release -cs).list && sudo apt-get --quiet update && sudo apt-get --yes --quiet --allow-unauthenticated install medibuntu-keyring && sudo apt-get --quiet update > /dev/null

# Google
if ! grep google /etc/apt/sources.list > /dev/null
    then
        echo 'Adding Google repository...'
        wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - apt-get update > /dev/null
        repo 'deb http://dl.google.com/linux/deb/ stable non-free'
    else
        echo 'Google repository already in place.'

fi
#add google-desktop-linux



#PlayOnLinux
if ! grep playonlinux /etc/apt/sources.list > /dev/null
    then
        echo 'Adding PlayOnLinux repository...'
        repo 'deb http://deb.playonlinux.com/ lucid main'
fi

#Skype
if ! grep skype /etc/apt/sources.list > /dev/null
    then
        repo 'deb http://download.skype.com/linux/repos/debian/ stable non-free'
fi

# VirtualBox
repo ppa:debfx/virtualbox/ubuntu

# if ! grep virtualbox /etc/apt/sources.list
#     then
#         echo 'Adding VirtualBox.org repository...'
#         wget -q http://download.virtualbox.org/virtualbox/debian/oracle_vbox.asc -O- | sudo apt-key add - > /dev/null
#         repo 'deb http://download.virtualbox.org/virtualbox/debian lucid non-free'
#         add dkms # Updates vbox host kernel modules when kernel is updated.
# fi
add virtualbox

### Adobe
### add acroread acroread-fonts
### update
### check


#Chromium daily debs — Google’s browser:
repo ppa:chromium-daily/ppa
repo ppa:chromium-daily/beta/ppa
# add chromium-browser

#Docky development
#repo ppa:docky-core/ppa

#Unetbootin put ISO dist onto USB drive, or any random partition.
#repo ppa:gezakovacs/ppa
#add unetbootin

#Globalmenu
#repo ppa:globalmenu-team/ppa

#Updates to Gnome Shell:
#repo ppa:ricotz/testing
#add gnome-shell

#Wine updates:
repo ppa:ubuntu-wine/ppa

# Gimp, latest as of Lucid
# repo ppa:matthaeus123/mrw-gimp-svn
# update
# check
# add gimp gimp-data gimp-plugin-registry gimp-data-extras

#Audacity audio editor
repo ppa:audacity-team/daily
#########################sudo apt-key add –recv-keys –keyserver keyserver.ubuntu.com 5EC48884BB901940
add audacity

#Emule
#repo ppa:happyaron/amule-dlp
#update
#check
#add amule-dlp amule-dlp-gnome-support amule-dlp-utils-gui amule-dlp-daemon

# Elementary and its desktop enhancements.  Nautilus and icons, notably.
repo ppa:elementaryart/ppa
add nautilus
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
sudo su
echo "export LIBOVERLAY_SCROLLBAR=0" > /etc/X11/Xsession.d/80overlayscrollbars
echo 'Done!'

########echo "~/scripts/coffee.sh"
#########~/scripts/coffee.sh
