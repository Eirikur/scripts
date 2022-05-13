#!/bin/bash

CODENAME=`grep UBUNTU_CODENAME /etc/os-release | cut -d= -f2`
if [ -z "$CODENAME" ]
then
   CODENAME=`lsb_release -c -s`
fi;
wget -O - http://nuitka.net/deb/archive.key.gpg | sudo apt-key add -
echo "deb http://nuitka.net/deb/develop/$CODENAME $CODENAME main" | sudo tee /etc/apt/sources.list.d/nuitka.list 
sudo apt-get update -y
sudo apt-get install -y nuitka

