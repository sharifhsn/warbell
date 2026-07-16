#!/usr/bin/env sh
set -eu

ROOT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
DEVKITPRO=${DEVKITPRO:-/tmp/devkitpro-switch1/opt/devkitpro}
LOG_DIR=${LOG_DIR:-$ROOT_DIR/target/switch-nro/logs}

if [ "$#" -ne 2 ]; then
  echo "usage: $0 <game|probe> <switch-ip>" >&2
  exit 2
fi
SWITCH_APP=$1
case "$SWITCH_APP" in
  game|probe) ;;
  *) echo "first argument must be game or probe" >&2; exit 2 ;;
esac
NRO=${NRO:-$ROOT_DIR/target/switch-nro/$SWITCH_APP/cargo-target/horizon-newlib-gcc/debug/warbell-switch.nro}
if [ ! -x "$DEVKITPRO/tools/bin/nxlink" ]; then
  echo "missing nxlink under $DEVKITPRO/tools/bin" >&2
  exit 1
fi
if [ ! -f "$NRO" ]; then
  echo "missing NRO: $NRO" >&2
  echo "run tools/build-switch-nro.sh first" >&2
  exit 1
fi
BUILD_INFO="$NRO.build-info.txt"
[ -f "$BUILD_INFO" ] && [ "$(awk -F= '$1 == "switch_app" { print $2 }' "$BUILD_INFO")" = "$SWITCH_APP" ] || {
  echo "NRO metadata does not identify a $SWITCH_APP build" >&2
  exit 1
}

mkdir -p "$LOG_DIR"
LOG="$LOG_DIR/nxlink-$(date +%Y%m%d-%H%M%S).log"
echo "logging nxlink output to $LOG"
"$DEVKITPRO/tools/bin/nxlink" -s -a "$2" "$NRO" 2>&1 | tee "$LOG"
