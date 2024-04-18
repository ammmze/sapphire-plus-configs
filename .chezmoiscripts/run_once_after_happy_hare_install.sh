#!/usr/bin/env bash

TARGET_DIR="${HOME}/Happy-Hare"

if [ ! -d "${TARGET_DIR}" ]; then
  git clone https://github.com/moggieuk/Happy-Hare.git "${TARGET_DIR}"
fi

cd "${TARGET_DIR}"
./install.sh -i
