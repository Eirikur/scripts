#!/bin/bash
# Script to install node (Node.js), npm (Node Package Manager) and
# Coffeescript by Eirikur Hallgrimsson, November 2010
# Revised 18 May 2011 to accomodate npm >= 1.0

# new 22 July 2011 for Rainer's machine
# sudo apt-get install build-essential
# sudo apt-get install git
# sudo apt-get install libssl-dev


# Create a directory tree under our home dir.
mkdir --parents ~/local/bin # Create ~/local/bin, creating local if needbe.
mkdir --parents ~/local/share/man
mkdir ~/local/.node_libraries
rm -rf ~/local/src
mkdir ~/local/src

echo "Checking for git..."
if ! which git
    then
        echo "Please install the git version control system and try again."
        exit
    else
        echo "You've got git.  Good!"
fi


# Get Node from the repository, build it, and install it.
cd ~/local/src
rm -rf node
#git clone https://github.com/ry/node.git # node got absorbed by Joyent, Inc.
git clone https://github.com/joyent/node.git
cd node
./configure --prefix=$HOME/local/ # Installation will be under ~/local

########################################################################git checkout v0.4.12
make -j3  # Going back to j3 24 April 2012
make install
