#!/usr/bin/env bash

/bin/bash -c "$(curl -fsSL https://octoapp.eu/install.sh)"

# TODO: ^ this didn't really work well...it cloned, but actual install didn't go correctly
# Probably should just use chezmoiexternal to clone it and run the installer ourselves like this:
# ./install.sh ~/printer_data/config/moonraker.conf moonraker.service
