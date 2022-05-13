#!/bin/bash

source='~/Configuration/firefox/'
s_minus='/home/eh/Configuration/firefox'
destination='/usr/share/ubuntu-system-adjustments/firefox/'
d_minus='/usr/share/ubuntu-system-adjustments/'

k5="/usr/share/kservices5/searchproviders/"

cinnamon='/usr/share/cinnamon/search_providers/'
mint_holding="~/Customization/current-firefox-mint/"
mkdir -pv "$mint_holding"


# Nuke the supplied search plugins
sudo rm -rfv "$cinnamon*.com"
sudo rm -v "$cinnamon*.xml"
sudo rm -rfv "$cinnamonduckduckgo@linuxmint.com"
sudo rm -rfv "$k5wikipedia*"

# Nuke some search plugin settings
rm -rfv ~/.mozilla/firefox/current.default/search.json.mozlz4


rm -rf "$mint_holding"
cp -rauvx "$destination" "$mint_holding" # Copy the latest Mint shennanigans

sudo cp -rauvx "$s_minus" "$d_minus"
