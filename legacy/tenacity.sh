#!/bin/bash

flatpak remote-add tenacity oci+https://tenacityteam.github.io/tenacity-flatpak-nightly
flatpak install tenacity org.tenacityaudio.Tenacity

