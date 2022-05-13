#!/bin/bash
echo 'Current wireless cards:'
lspci | grep Wireless

# Pulls in the whole ndis system without requiring a hard-coded
# version here.
apt-get install --assume-yes --force-yes ndisgtk

apt-get purge --assume-yes bcmwl-kernel-source 
apt-get purge --assume-yes bcmwl-modaliases

apt-get install --assume-yes --force-yes --download-only bcmwl-kernel-source 
apt-get install --assume-yes --force-yes --download-only bcmwl-modaliases


echo 'Stopping network...'
/etc/init.d/networking stop
echo 'Shutting off card slot...'
pccardctl eject 0
echo 'Reinstalling the bcmwl driver for the WPC600N...'
# Must force this because it warns about this not-Free driver.
# what about --no-download if .debs are present?
apt-get install --reinstall --assume-yes --force-yes bcmwl-kernel-source 
apt-get install --reinstall --assume-yes --force-yes bcmwl-modaliases
pccardctl resume 0 # restore power to the card slot
pccardctl insert 0
echo 'Power restored to card slot.  What adapters do we see?'
lspci | grep Wireless
echo 'Starting network...'
/etc/init.d/networking start
