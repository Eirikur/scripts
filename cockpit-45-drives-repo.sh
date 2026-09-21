#!/bin/bash
curl -sSL https://repo.45drives.com/setup | sudo bash
sudo apt-get update
sudo apt install -y cockpit-file-sharing
