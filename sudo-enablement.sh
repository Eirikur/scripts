#!/bin/bash

echo 'Enabling sudo'
sudo adduser eh sudo
sudo echo 'eh ALL=(ALL) NOPASSWD:ALL' | sudo tee /etc/sudoers.d/eh # tee hack avoids IO redirect which does not work.
echo "Done with sudo enablement."
