#!/bin/bash
wget -qO - http://images.45drives.com/repo/keys/aptpubkey.asc | apt-key add -
sudo su
curl -o /etc/apt/sources.list.d/45drives.list http://images.45drives.com/repo/debian/45drives.list
sudo apt update
sudo apt install cockpit-file-sharing