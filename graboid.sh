#!/bin/bash
if ! command -v evtest >/dev/null 2>&1
then
    sudo apt install -y evtest
fi

device="$1"
device_line="$(lsusb | grep $device)"
echo "$device_line"
