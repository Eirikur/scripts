#!/bin/bash
cd ~/
pwd
cp .bashrc bashrc-coffee
tar -jcvf coffee.tar.bz2 bashrc-coffee coffee local node_modules
 
