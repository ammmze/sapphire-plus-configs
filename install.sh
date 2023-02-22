#!/usr/bin/env bash

KLIPPER_CONFIG_DIR=~/printer_data/config

mkdir -p "${KLIPPER_CONFIG_DIR}/modules"

if [ ! -d ~/print_area_bed_mesh ]; then
    git clone https://github.com/Turge08/print_area_bed_mesh.git ~/print_area_bed_mesh
    ln -sf ~/print_area_bed_mesh/print_area_bed_mesh.cfg "${KLIPPER_CONFIG_DIR}/modules/print_area_bed_mesh.cfg"
fi

if [ ! -d ~/klipper-led_effect ]; then
    git clone https://github.com/julianschill/klipper-led_effect.git ~/klipper-led_effect
    ( cd ~/klipper-led_effect && ./install-led_effect.sh )
fi
