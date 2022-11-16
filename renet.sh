#!/bin/bash
sudo service network-manager stop
sudo rm /var/lib/NetworkManager/NetworkManager.state
sudo systemctl stop networking
sudo systemctl start networking
sudo service network-manager start
