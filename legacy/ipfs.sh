#!/bin/bash
cd ~/Projects/External/
git clone https://github.com/ipfs-shipyard/ipfs-desktop.git
cd ipfs-desktop
npm ci
npm run build
npm start
