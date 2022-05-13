#!/bin/bash
file='/home/eh/Configuration/etc.tar.xz'
cd /
sudo rm -rf etc-old
sudo mv etc etc-old
sudo tar -Jxvf $file
cd -


