#!/bin/bash
### Backup system configuration
path="$HOME/Configuration/System"
bkp=`dirname $path`/`basename $path`
pkgs="$bkp/apt"
mkdir -p "$pkgs" -v # Creates tree as needed.
dpkg --get-selections > "$pkgs"/Package.list
sudo cp -R /etc/apt/sources.list* "$pkgs"/
sudo apt-key exportall > "$pkgs"/Repo.keys &>/dev/null

sudo apt install -y apt-clone -qq  &>/dev/null
clone="$pkgs/apt-clone"
mkdir -p "$clone"
apt-clone clone "$clone/my-mint" &>/dev/null
cd "$clone" && tar -xf "my-mint.apt-clone.tar.gz" && cd - &>/dev/null
sudo cp -raux /etc "$path"
sudo chown -R "$USER:$USER" "$path"
