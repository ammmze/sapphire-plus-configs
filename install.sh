#!/usr/bin/env bash

KLIPPER_CONFIG_DIR=~/printer_data/config

mkdir -p "${KLIPPER_CONFIG_DIR}/modules.d"

if [ ! -d ~/Klipper-Adaptive-Meshing-Purging ]; then
    git clone https://github.com/kyleisah/Klipper-Adaptive-Meshing-Purging.git ~/Klipper-Adaptive-Meshing-Purging
    ln -s ~/Klipper-Adaptive-Meshing-Purging/Configuration "${KLIPPER_CONFIG_DIR}/modules/KAMP"
    echo '[include modules.d/KAMP/*.cfg]' > "${KLIPPER_CONFIG_DIR}/modules/KAMP.cfg"
fi

if [ ! -d ~/klipper-led_effect ]; then
    git clone https://github.com/julianschill/klipper-led_effect.git ~/klipper-led_effect
    ( cd ~/klipper-led_effect && ./install-led_effect.sh )
fi
