#!/usr/bin/env bash
qemu-system-x86_64 \
   -nic user,model=virtio-net-pci \
   -enable-kvm -m 2048 \
   -device virtio-blk,drive=myhd \
   -drive if=none,file=~/VMs/guix-system-vm-image-1.4.0.x86_64-linux.qcow2,id=myhd





