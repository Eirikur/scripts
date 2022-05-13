#!/bin/bash
udisksctl mount -b /dev/sda1 &> /dev/null
rm ~/.cache/* -rf
rm ~/.local/share/Trash/* -rf
rsync -av /home/eh '/media/eh/Internal Tank/'
