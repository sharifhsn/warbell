#!/usr/bin/env sh
set -eu

ROOT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
DEVKITPRO=${DEVKITPRO:-/tmp/devkitpro-switch1/opt/devkitpro}
NRO=${NRO:-$ROOT_DIR/target/switch-nro/cargo-target/horizon-newlib-gcc/debug/warbell-switch.nro}

if [ "$#" -ne 1 ]; then
  echo "usage: $0 <switch-ip>" >&2
  exit 2
fi
if [ ! -x "$DEVKITPRO/tools/bin/nxlink" ]; then
  echo "missing nxlink under $DEVKITPRO/tools/bin" >&2
  exit 1
fi
if [ ! -f "$NRO" ]; then
  echo "missing NRO: $NRO" >&2
  echo "run tools/build-switch-nro.sh first" >&2
  exit 1
fi

exec "$DEVKITPRO/tools/bin/nxlink" -s -a "$1" "$NRO"
