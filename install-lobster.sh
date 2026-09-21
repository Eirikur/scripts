#!/usr/bin/env bash

echo "Fetching the lobster language..."
lobster --version
sudo curl -sL github.com/justchokingaround/lobster/raw/main/lobster.sh -o ~/Applications//lobster/lobster &&
sudo chmod +x ~/Applications/lobster/lobster
lobster --version
