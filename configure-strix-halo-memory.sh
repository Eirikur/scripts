#!/bin/bash
# 1️⃣ One-time: raise the unified-memory GPU ceiling (the single biggest win: ×2.8 !)
#    Default GTT = half your RAM. On a 128 GB box you want ~110 GiB:
echo "Setting GPU memory partition to 110GiB..."
echo 'GRUB_CMDLINE_LINUX_DEFAULT="$GRUB_CMDLINE_LINUX_DEFAULT amdgpu.gttsize=112640 ttm.pages_limit=28835840"' \
  | sudo tee /etc/default/grub.d/99-amdgpu-gtt.cfg
sudo update-grub && sudo reboot
