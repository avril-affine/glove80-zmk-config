#!/usr/bin/env bash

set -e -x

SCRIPT_DIR=$(dirname $(readlink -f $0))
APP_DIR="${SCRIPT_DIR}/zmk/app"
CONFIG_DIR="${SCRIPT_DIR}/config"
OUT="${SCRIPT_DIR}/build/$(date -Iseconds).uf2"

cd $APP_DIR
west build -p -b glove80_lh -d build/left -- -DZMK_CONFIG=$CONFIG_DIR
west build -p -b glove80_rh -d build/right -- -DZMK_CONFIG=$CONFIG_DIR
mkdir -p "$(dirname $OUT)"
cat build/left/zephyr/zmk.uf2 build/right/zephyr/zmk.uf2 > $OUT
ln -sf $OUT "${SCRIPT_DIR}/latest.uf2"
cd -
