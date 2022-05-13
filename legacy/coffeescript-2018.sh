#!/bin/bash

# npm -v

# read -p "Press enter to continue"

# npm i -g npm

# echo "If npm requires further updates, restart this script." 

# read -p "Press enter to continue"



# npm cache clean -f
# npm install -g n
# n stable

# Add any requirements here
sudo apt install -y build-essential git libssldev



# create a directory tree under our home dir.
set +x
mkdir --parents ~/local/bin # Create ~/local/bin, creating local if needbe.
mkdir --parents ~/local/share/man
mkdir ~/local/.node_libraries
rm -rf ~/local/src
mkdir ~/local/src

# Work in ~/local/source
cd ~/local/src

for file in `lynx -dump https://nodejs.org/dist/latest/  | grep 'linux-x64.tar.xz' | awk {'print $2'}`;do wget $file;done

tar -Jxvf *

cd node*/ # A bit fragile, but it works 26-Jun-2018
pwd

./configure --prefix=$HOME/local/ # Installation will be under ~/local

make -j6  # Going back to j3 24 April 2012
make install

# Ok, now the node executable is installed in ~/local/bin
# We need to put that in our path.
export PATH=$HOME/local/bin:$PATH # For this session
export PATH=$HOME/local/share/man:$PATH #
# Since I'm keeping my old pre-configured .bashrc, this is not required.
# echo 'export PATH=~/local/bin:${PATH}' >> ~/.bashrc # For subsequent sessions.
# echo 'export PATH=~/local/share/man:${PATH}' >> ~/.bashrc
cd
echo 'Done.'
exit













# # Script to install node (Node.js), npm (Node Package Manager) and
# # Coffeescript by Eirikur Hallgrimsson, November 2010
# # Revised 18 May 2011 to accomodate npm >= 1.0



# # # Get Node from the repository, build it, and install it.
# # rm -rf node
# # #git clone https://github.com/ry/node.git # node got absorbed by Joyent, Inc.
# # git clone https://github.com/joyent/node.git
# cd ~/local/src
# wget https://nodejs.org/dist/latest/node-v8.4.0-linux-x64.tar.xz
# # wget http://nodejs.org/dist/v0.10.24/node-v0.10.24.tar.gz
# tar -Jxvf node-v8.4.0-linux-x64.tar.xz
# cd node*/
# cp -rauvx * ~/local/
# # Now using binary distribution.
# #./configure --prefix=$HOME/local/ # Installation will be under ~/local

# exit

# ########################################################################git checkout v0.4.12
# make -j3  # Going back to j3 24 April 2012
# make install

# # Ok, now the node executable is installed in ~/local/bin
# # We need to put that in our path.
# export PATH=$HOME/local/bin:$PATH # For this session
# export PATH=$HOME/local/share/man:$PATH #
# # echo 'export PATH=~/local/bin:${PATH}' >> ~/.bashrc # For subsequent sessions.
# # echo 'export PATH=~/local/share/man:${PATH}' >> ~/.bashrc


# # We need to set up defaults for npm before installing it.
# cat >>~/.npmrc <<NPMRC

# root = ~/local/.node_libraries
# binroot = ~/local/bin
# manroot = ~/local/share/man
# NPMRC

# # # Get npm (Node package manager), built it and install it.
# # cd ~/local/src
# # rm -rf npm
# # git clone https://github.com/isaacs/npm.git
# # cd npm
# # ./configure --prefix=$HOME/local/ # Installation will be under ~/local
# # make -j4 install

# # Clean up source files. Many small files taking up a lot of space.
# rm -rf ~/local/src


# # Now we can use npm to install CoffeeScript.  Yes, npm knows it as 'coffee-script.'
# # That -g in the command is CRITICAL.  Otherwise the install goes into ~/.npm
# # This is an npm issue where using npm to install libraries "local" to a project
# # is deemed the normal cafse in npm > 1.0

# # npm install -g coffee-script
# # which coffee
# # coffee -e '{print, puts, debug, error, inspect, p, log, pump, inherits} = require "util"; puts "Greetings printed by CoffeeScript!"'
# # echo "See http://nodul.es/ for an index of other tools and libraries for Node."
# # echo "Any of those can be imported and used by CoffeeScript."