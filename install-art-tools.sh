#!/usr/bin/env bash

# Tell BASH to expand aliases.
shopt -s expand_aliases

alias add='sudo DEBIAN_FRONTEND=noninteractive apt-get -yuV install --install-recommends -qq '
alias repo='yes | sudo add-apt-repository -y'
##alias getkey='sudo apt-key'
alias update='sudo apt-get -qq update' # -qq is safe here.
alias check='sudo apt-get check -qq'
alias purge='sudo apt-get autoremove -qq; sudo apt-get autoclean -qq'
alias rm='sudo apt-get -yuV remove -qq'
alias overwrite='sudo apt-get -o Dpkg::Options::="--force-overwrite" install --reinstall -y'
