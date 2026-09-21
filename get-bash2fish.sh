#!/usr/bin/env bash
dest="~/Projects/External/Shell"
mkdir -p "$dest"
cd "$dest"
git clone --recursive https://github.com/konchunas/bash2fish.git
cd shelljs-transpiler/
npm install
cd -

