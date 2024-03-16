#!/usr/bin/env bash


on_error() {
    set +x
    while [ $(dirs | wc -w) -gt 1 ]; do
        popd
    done
    exit 1
}

trap "on_error" ERR
set -x

if ! command -v west; then
    echo 'west is not install. try "pip install west"'
    exit 1
fi

if [ ! -d "zmk/zephyr" ]; then
    pushd zmk
    west init -l app/
    popd
fi

if [ ! -d "zmk/modules" ]; then
    pushd zmk
    west update
    west zephyr-export
    popd
fi

SCRIPT_DIR=$(dirname $(readlink -f $0))
APP_DIR="${SCRIPT_DIR}/zmk/app"
CONFIG_DIR="${SCRIPT_DIR}/config"
OUT="${SCRIPT_DIR}/build/$(date -Iseconds).uf2"

pushd $APP_DIR
echo $PWD
west build -p -b glove80_lh -d build/left -- -DZMK_CONFIG=$CONFIG_DIR
west build -p -b glove80_rh -d build/right -- -DZMK_CONFIG=$CONFIG_DIR
mkdir -p "$(dirname $OUT)"
cat build/left/zephyr/zmk.uf2 build/right/zephyr/zmk.uf2 > $OUT
ln -sf $OUT "${SCRIPT_DIR}/latest.uf2"
popd
