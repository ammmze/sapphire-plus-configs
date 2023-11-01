#!/usr/bin/env bash

cd ~/obico
./install.sh \
    -H $(hostname).packnet.cc \
    -p 80 \
    -C "${HOME}/printer_data/config/moonraker.conf" \
    -l "${HOME}/printer_data/logs/moonraker-obico-80.log" \
    -S https://obico.cashmedia.me
