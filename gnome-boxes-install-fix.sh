#!/usr/bin/env bash
lsmod | grep kvm
echo 'need to be in kvm group'
sudo apt install cpu-checker
sudo kvm-ok




sudo systemctl enable --now libvirtd
