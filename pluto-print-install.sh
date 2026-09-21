#!/usr/bin/env bash
# Supposedly only for building
sudo apt-get install -y \
   build-essential pkg-config \
   meson ninja-build \
   libcairo2-dev libexpat1-dev libfontconfig1-dev libfreetype6-dev \
   libharfbuzz-dev libicu-dev \
   libcurl4-openssl-dev libturbojpeg0-dev libwebp-dev

# This succeed. THe above not needed?

pip install plutoprint

