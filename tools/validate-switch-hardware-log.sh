#!/usr/bin/env sh
set -eu

if [ "$#" -ne 2 ]; then
  echo "usage: $0 <probe|compute> <nxlink-log>" >&2
  exit 2
fi

TEST_KIND=$1
LOG=$2

case "$TEST_KIND" in
  probe|compute) ;;
  *) echo "first argument must be probe or compute" >&2; exit 2 ;;
esac

if [ ! -f "$LOG" ]; then
  echo "missing nxlink log: $LOG" >&2
  exit 1
fi

require_log() {
  pattern=$1
  description=$2
  if ! grep -a -F "$pattern" "$LOG" >/dev/null 2>&1; then
    echo "missing hardware evidence: $description" >&2
    echo "required text: $pattern" >&2
    exit 1
  fi
}

if grep -a -E -i \
  'panicked at|thread .* panicked|validation error|device (lost|error)|shader[^[:cntrl:]]*(compile|compiler|validation)[^[:cntrl:]]*(error|failed)|phase=asset_probe_error|phase=(full|game)_not_ready|failed to mount RomFS' \
  "$LOG" >/dev/null 2>&1; then
  echo "hardware log contains a fatal compiler, device, validation, or asset error" >&2
  grep -a -E -i \
    'panicked at|thread .* panicked|validation error|device (lost|error)|shader[^[:cntrl:]]*(compile|compiler|validation)[^[:cntrl:]]*(error|failed)|phase=asset_probe_error|phase=(full|game)_not_ready|failed to mount RomFS' \
    "$LOG" >&2 || true
  exit 1
fi

case "$TEST_KIND" in
  probe)
    require_log '[warbell-switch] phase=romfs_mount_ok' 'RomFS mounted'
    # Horizon's stdio adapter may emit formatted arguments as separate debug
    # records. Require the success marker plus every expected path so both the
    # split and single-line nxlink forms validate correctly.
    require_log '[warbell-switch] phase=asset_probe_ok path=' 'asset probe success telemetry'
    require_log 'romfs:/assets/fonts/Cinzel.ttf' 'font loaded from RomFS'
    require_log 'romfs:/assets/ui/menu_backdrop.png' 'PNG loaded from RomFS'
    require_log 'romfs:/assets/shaders/terrain.wgsl' 'WGSL loaded from RomFS'
    require_log '[wgpu-deko3d] shader_cache key=' 'runtime compiler cache telemetry'
    require_log 'shader_source=runtime_wgsl' 'runtime WGSL frame telemetry'
    require_log '[warbell-switch-probe] phase=probe_ready frame=60' 'vertex/fragment probe reached frame 60'
    ;;
  compute)
    require_log 'deko-wgpu-public-runtime-compute-rs: start (runtime WGSL)' 'runtime WGSL compute started'
    require_log 'deko-wgpu-public-runtime-compute-rs: ok values=[7, 13, 19, 25]' 'storage-buffer dispatch and readback matched'
    ;;
esac

echo "$TEST_KIND hardware log passed automated validation: $LOG"
