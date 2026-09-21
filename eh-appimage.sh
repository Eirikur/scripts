#!/usr/bin/env bash
# My appimage handler for firefox downloads
set -x
it="$1"
chmod +x "$it"
gnome-terminal -- "$(pwd)/$it"


