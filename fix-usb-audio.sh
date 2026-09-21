#!/bin/bash

SHARKOON_CARD="alsa_card.usb-Tdlasunnic_Sharkoon_Mobile_DAC_PD_20181228.1-00"
LOGITECH_CARD="alsa_card.usb-046d_Logitech_Webcam_C930e_FC984B7E-02"

card_exists() {
    pactl list short cards | grep -q "$1"
}

if card_exists "$SHARKOON_CARD"; then
    echo "Waking Sharkoon DAC..."
    pactl set-card-profile "$SHARKOON_CARD" output:iec958-stereo+input:iec958-stereo
    sleep 0.3
    pactl set-card-profile "$SHARKOON_CARD" output:analog-stereo+input:analog-stereo
else
    echo "Sharkoon DAC not connected."
fi

if card_exists "$LOGITECH_CARD"; then
    echo "Waking Logitech mic..."
    pactl set-card-profile "$LOGITECH_CARD" input:iec958-stereo
    sleep 0.3
    pactl set-card-profile "$LOGITECH_CARD" input:analog-stereo
else
    echo "Logitech mic not connected."
fi
