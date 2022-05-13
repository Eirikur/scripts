#!/bin/bash

ISSUE="bionic"
RELEASE="5.2"

### Virtualbox
if ! grep -iq virtualbox /etc/apt/sources.list; then
    echo "deb https://download.virtualbox.org/virtualbox/debian bionic contrib\n" >> /etc/apt/sources.list
    echo "Added virtualbox.org source for BIONIC packages."
else
    echo "Virtualbox.org is already in /etc/apt/sources.list."
fi

wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -

sudo apt-get update
sudo apt-get install virtualbox-5.2
