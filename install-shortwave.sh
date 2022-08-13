#!/bin/bash

sudo apt install -y flatpak

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

sudo flatpak install -y flathub de.haeckerfelix.Shortwave

flatpak run de.haeckerfelix.Shortwave

