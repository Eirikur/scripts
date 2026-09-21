#!/bin/bash
qemu-system-x86_64 -display sdl -cpu Nehalem-v2 -machine q35 \
                    -m 1024 -drive format=raw,file=sculpt-25-04.img \
                    -Netdev user,id=net0 -device e1000,netdev=net0

 
