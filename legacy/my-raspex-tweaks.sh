#!/bin/bash

# Remove the swap FILE 
sudo dphys-swapfile swapof
sudo dphys-swapfile uninstall
sudo systemctl disable dphys-swapfile

