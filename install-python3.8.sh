#!/usr/bin/env bash


# Install build dependencies

sudo apt-get update

sudo apt-get install -y build-essential libssl-dev zlib1g-dev libbz2-dev \
                        libreadline-dev libsqlite3-dev wget curl llvm \
                        libncurses5-dev libncursesw5-dev xz-utils tk-dev \
                        libffi-dev liblzma-dev python3-openssl git

# Download and extract Python 3.8 source code

mkdir ~/python38
cd ~/python38
wget https://www.python.org/ftp/python/3.8.16/Python-3.8.16.tgz
tar -xf Python-3.8.16.tgz


cd Python-3.8.16

# Configure the build

./configure --enable-optimizations

# Compile the source code

make -j 4

# Install Python
sudo make install
# Verify the installation

python3.8 --version
