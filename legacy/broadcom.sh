#!/bin/bash
echo "Broadcom bcmwl for Broadcom STA internal and Linksys WPC600N dual-band N cards."
sudo apt-get install --reinstall --assume-yes --force-yes bcmwl-kernel-source 
sudo apt-get install --reinstall --assume-yes --force-yes bcmwl-modaliases
