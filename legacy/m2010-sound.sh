#!/bin/bash
set +x
echo "0x0a 0x0321121F" > /sys/class/sound/hwC0D0/user_pin_configs
echo "0x0b 0x01112024" > /sys/class/sound/hwC0D0/user_pin_configs
echo "0x0c 0x01111222" > /sys/class/sound/hwC0D0/user_pin_configs
echo "0x0d 0x91174220" > /sys/class/sound/hwC0D0/user_pin_configs
echo "0x0e 0x03811032" > /sys/class/sound/hwC0D0/user_pin_configs
echo "0x0f 0x01116221" > /sys/class/sound/hwC0D0/user_pin_configs
echo "0x10 0x01452340" > /sys/class/sound/hwC0D0/user_pin_configs
echo "0x11 0x40C003F1" > /sys/class/sound/hwC0D0/user_pin_configs
echo "0x15 0x90A70330" > /sys/class/sound/hwC0D0/user_pin_configs
echo "0x1b 0x405003F0" > /sys/class/sound/hwC0D0/user_pin_configs
echo 1 > /sys/class/sound/hwC0D0/reconfig
hda-verb /dev/snd/hwC0D0 0x1 set_gpio_data 0x05
hda-verb /dev/snd/hwC0D0 0x1 set_gpio_dir 0x05
hda-verb /dev/snd/hwC0D0 0x1 set_gpio_mask 0x05
