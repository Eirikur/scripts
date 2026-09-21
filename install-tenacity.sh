#!/bin/bash

flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak install org.tenacityaudio.Tenacity

flatpak run org.tenacityaudio.Tenacity

