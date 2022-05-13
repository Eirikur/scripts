#!/bin/bash
#set -x # Trace
#set -e # Exit on error
cd $1
cp .emacs ./emacs # safekeeping
cp .bashrc ./scripts/bashrc
tar -cf tarchive.tar .ssh .bashrc .emacs emacs .mozilla .thunderbird coffee local Applications Web .gkrellm2 Customizations
