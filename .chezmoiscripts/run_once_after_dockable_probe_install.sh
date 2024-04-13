#!/usr/bin/env bash

PACKAGE_DIR="${HOME}/klipper-dockable-probe"
PLUGIN_SRC="${PACKAGE_DIR}/klippy/extras/dockable_probe.py"
PLUGIN_DEST="${HOME}/klipper/klippy/extras/dockable_probe.py"
BRANCH='work-annex-probe'
REPO='https://github.com/cloakedcode/klipper.git'

if [ -f "${PLUGIN_DEST}" ]; then
    echo "[INFO] Skipping installation of $(basename "${PLUGIN_DEST}") because the file already exists."
    exit 0
fi

rm -fr "${PACKAGE_DIR}"
git clone -b "${BRANCH}" "${REPO}" "${PACKAGE_DIR}"

if [ ! -f "${PLUGIN_SRC}" ]; then
    echo "[ERROR] Plugin file (${PLUGIN_SRC}) was not found. Cannot install it into klipper."
    exit 1
fi

ln -s "${PLUGIN_SRC}" "${PLUGIN_DEST}"
