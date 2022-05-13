#!/bin/bash
sudo apt update
sudo apt install devscripts gcc git libaio-dev libattr1-dev libblkid-dev libkeyutils-dev liblz4-dev libscrypt-dev libsodium-dev liburcu-dev libzstd-dev make pkg-config uuid-dev zlib1g-dev

sudo apt build-dep linux -y

git clone https://evilpiepirate.org/git/bcachefs-tools.git

git clone https://evilpiepirate.org/git/bcachefs.git

# Edit Bcachefs-Tools Makefile removing pytest

# $ cd bcachefs-tools

# $ nano +79 Makefile

#check: tests bcachefs
#    cd tests; $(PYTEST)

# Build BcacheFS-tools

$ cd bcachefs-tools && make deb && cd ..

# Build BcacheFS
# Get your kernel config:

# There are plenty of different ways to configure the kernel, but I would recommend either grabbing a kernel config from one of the Ubuntu Mainline Builds or grab one of your existing configs from /boot/config-* 

# You just have to download the linux-headers-*-generic_*_amd64.deb file and extract it somewhere. Inside that, you’ll need to extract the data.tar file. You’ll want to copy the /./usr/src/linux-headers-*-generic/.config file. 

# Then just copy the .config into the bcachefs directory. 
