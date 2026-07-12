#!/usr/bin/env sh
set -eu

ROOT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
DEVKITPRO=${DEVKITPRO:-/tmp/devkitpro-switch1/opt/devkitpro}
NRO=${NRO:-$ROOT_DIR/target/switch-nro/cargo-target/horizon-newlib-gcc/debug/warbell-switch.nro}
LOG_DIR=${LOG_DIR:-$ROOT_DIR/target/switch-nro/logs}

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

mkdir -p "$LOG_DIR"
LOG="$LOG_DIR/nxlink-$(date +%Y%m%d-%H%M%S).log"
echo "logging nxlink output to $LOG"
"$DEVKITPRO/tools/bin/nxlink" -s -a "$1" "$NRO" 2>&1 | tee "$LOG"
