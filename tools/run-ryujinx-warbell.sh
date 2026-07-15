#!/usr/bin/env sh
set -eu

ROOT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
NRO=${NRO:-$ROOT_DIR/target/switch-nro/cargo-target/horizon-newlib-gcc/debug/warbell-switch.nro}
RYUJINX_APP=${RYUJINX_APP:-$ROOT_DIR/../switch/target/ryujinx-d3-fixed/bundle/Ryujinx.app}
LOG_DIR=${LOG_DIR:-$ROOT_DIR/target/ryujinx-logs}
OVERRIDE_DIR=${RYUJINX_SD_ROOT:-$HOME/Library/Application Support/Ryujinx/sdcard}/switch/warbell-shader-overrides
ORIGINAL_REFLECTION_DIR=${RYUJINX_SD_ROOT:-$HOME/Library/Application Support/Ryujinx/sdcard}/switch/warbell-shaders
ALLOW_DIAGNOSTIC_OVERRIDES=${ALLOW_DIAGNOSTIC_OVERRIDES:-0}
ALLOW_EXPIRED_OVERRIDES=${ALLOW_EXPIRED_OVERRIDES:-0}
OVERRIDE_MAX_AGE_SECONDS=${OVERRIDE_MAX_AGE_SECONDS:-86400}
GOLDEN_SCREENSHOT=${GOLDEN_SCREENSHOT:-}
SCREENSHOT_REGIONS=${SCREENSHOT_REGIONS:-}
SCREENSHOT_REPORT=${SCREENSHOT_REPORT:-}
REQUIRED_LOG_PATTERN=${REQUIRED_LOG_PATTERN-'\[warbell-switch\] phase=acceptance_ready frame=60'}
FRAME_PROFILE=${FRAME_PROFILE:-$ROOT_DIR/tools/warbell-frame-profile.json}
READY_TIMEOUT_SECONDS=${READY_TIMEOUT_SECONDS:-${HEALTHCHECK_AFTER_SECONDS:-75}}
CAPTURE_DELAY_AFTER_READY=${CAPTURE_DELAY_AFTER_READY:-2}
CAPTURE_INTERVAL_SECONDS=${CAPTURE_INTERVAL_SECONDS:-2}
CAPTURE_COUNT=${CAPTURE_COUNT:-3}
VISUAL_CHECK=${VISUAL_CHECK:-1}
KEEP_EMULATOR_RUNNING=${KEEP_EMULATOR_RUNNING:-0}
if [ ! -f "$NRO" ] || [ ! -x "$RYUJINX_APP/Contents/MacOS/Ryujinx" ]; then
  echo "missing NRO or pinned D3-fixed Ryujinx app" >&2
  echo "build the emulator with ../switch/experiments/switch1-deko3d-wgpu/tools/build-ryujinx-d3-fixed.sh" >&2
  exit 1
fi
[ "$VISUAL_CHECK" = 0 ] || [ -f "$FRAME_PROFILE" ] || {
  echo "frame-validation profile not found: $FRAME_PROFILE" >&2
  exit 1
}
BUILD_INFO="$NRO.build-info.txt"
[ -f "$BUILD_INFO" ] || {
  echo "missing NRO build metadata: $BUILD_INFO" >&2
  echo "rebuild with SWITCH_EMULATOR=1 tools/build-switch-nro.sh" >&2
  exit 1
}
[ "$(awk -F= '$1 == "switch_emulator" { print $2 }' "$BUILD_INFO")" = 1 ] || {
  echo "NRO was not built for emulator TLS; rebuild with SWITCH_EMULATOR=1 tools/build-switch-nro.sh" >&2
  exit 1
}
expected_nro_sha=$(awk -F= '$1 == "sha256" { print $2 }' "$BUILD_INFO")
actual_nro_sha=$(shasum -a 256 "$NRO" | awk '{print $1}')
[ -n "$expected_nro_sha" ] && [ "$expected_nro_sha" = "$actual_nro_sha" ] || {
  echo "NRO hash does not match its build metadata" >&2
  exit 1
}
mkdir -p "$LOG_DIR" "$OVERRIDE_DIR"
for f in "$OVERRIDE_DIR"/*.dksh; do
  [ -e "$f" ] || continue
  meta=${f%.dksh}.json
  [ -f "$meta" ] || { echo "refusing untracked shader override: $f" >&2; exit 1; }
  artifact_sha=$(shasum -a 256 "$f" | awk '{print $1}')
  [ "$(jq -r '.artifact_sha256' "$meta")" = "$artifact_sha" ] ||
    { echo "override artifact hash mismatch: $f" >&2; exit 1; }
  override_reflection=${f%.dksh}.reflection.json
  [ -f "$override_reflection" ] ||
    { echo "override reflection is missing: $f" >&2; exit 1; }
  override_reflection_sha=$(shasum -a 256 "$override_reflection" | awk '{print $1}')
  [ "$(jq -r '.reflection_sha256' "$meta")" = "$override_reflection_sha" ] ||
    { echo "override reflection hash mismatch: $f" >&2; exit 1; }
  override_bindings=$(jq -c '[.resources[] | {group, binding, kind, binding_map_target}]' "$override_reflection")
  [ "$(jq -c '.binding_map_targets' "$meta")" = "$override_bindings" ] ||
    { echo "override binding manifest mismatch: $f" >&2; exit 1; }
  designation=$(jq -r '.designation' "$meta")
  expected_reflection=$(jq -r '.expected_original_reflection_sha256' "$meta")
  original_reflection="$ORIGINAL_REFLECTION_DIR/$(basename "${f%.dksh}").reflection.json"
  if [ ! -f "$original_reflection" ]; then
    request_prefix=$(basename "$f" | cut -c1-8)
    for candidate in "$ROOT_DIR/assets/shaders/deko3d-runtime/$request_prefix"-*.reflection.json; do
      [ -f "$candidate" ] || continue
      [ -z "${fallback_reflection:-}" ] ||
        { echo "multiple original reflections match $request_prefix" >&2; exit 1; }
      fallback_reflection=$candidate
    done
    original_reflection=${fallback_reflection:-$original_reflection}
    unset fallback_reflection
  fi
  if [ -f "$original_reflection" ]; then
    actual_reflection=$(shasum -a 256 "$original_reflection" | awk '{print $1}')
    [ "$actual_reflection" = "$expected_reflection" ] ||
      { echo "override reflection mismatch: $f" >&2; exit 1; }
    original_bindings=$(jq -c '[.resources[] | {group, binding, kind, binding_map_target}]' "$original_reflection")
    jq -en --argjson original "$original_bindings" --argjson override "$override_bindings" \
      'all($override[]; . as $resource | any($original[]; . == $resource))' >/dev/null ||
      { echo "override bindings are incompatible with the original shader: $f" >&2; exit 1; }
  else
    echo "refusing override without original reflection: $f" >&2
    exit 1
  fi
  case "$designation" in
    production) ;;
    diagnostic)
      [ "$ALLOW_DIAGNOSTIC_OVERRIDES" = 1 ] ||
        { echo "diagnostic override requires ALLOW_DIAGNOSTIC_OVERRIDES=1: $f" >&2; exit 1; }
      created_epoch=$(date -j -u -f %Y-%m-%dT%H:%M:%SZ "$(jq -r '.created_at' "$meta")" +%s)
      now_epoch=$(date -u +%s)
      age=$((now_epoch - created_epoch))
      [ "$age" -le "$OVERRIDE_MAX_AGE_SECONDS" ] || [ "$ALLOW_EXPIRED_OVERRIDES" = 1 ] ||
        { echo "diagnostic override expired after ${age}s: $f" >&2; exit 1; }
      ;;
    *) echo "invalid override designation in $meta" >&2; exit 1 ;;
  esac
done
diagnostic_flag_created=0
if [ "$ALLOW_DIAGNOSTIC_OVERRIDES" = 1 ]; then
  : > "$OVERRIDE_DIR/ALLOW_DIAGNOSTIC"
  diagnostic_flag_created=1
else
  rm -f "$OVERRIDE_DIR/ALLOW_DIAGNOSTIC"
fi
pid=
cleanup() {
  status=$?
  trap - EXIT INT TERM
  if [ "$diagnostic_flag_created" = 1 ]; then
    rm -f "$OVERRIDE_DIR/ALLOW_DIAGNOSTIC"
  fi
  if [ -n "$pid" ] && [ "$KEEP_EMULATOR_RUNNING" != 1 ] && kill -0 "$pid" 2>/dev/null; then
    kill "$pid" 2>/dev/null || true
    for _ in 1 2 3 4 5; do
      kill -0 "$pid" 2>/dev/null || break
      sleep 1
    done
    kill -9 "$pid" 2>/dev/null || true
    wait "$pid" 2>/dev/null || true
  fi
  exit "$status"
}
trap cleanup EXIT INT TERM

pkill -x Ryujinx 2>/dev/null || true
for _ in 1 2 3 4 5; do
  pgrep -x Ryujinx >/dev/null 2>&1 || break
  sleep 1
done
pgrep -x Ryujinx >/dev/null 2>&1 && {
  echo "stale Ryujinx process survived termination" >&2
  exit 1
}
stamp=$(date -u +%Y%m%dT%H%M%SZ)
run_dir="$LOG_DIR/warbell-$stamp"
mkdir -p "$run_dir"
log="$run_dir/ryujinx.log"
manifest="$run_dir/run.manifest"
screenshot=${SCREENSHOT:-$run_dir/final.png}
case "$NRO" in */release/*) inferred_build_mode=release ;; */debug/*) inferred_build_mode=debug ;; *) inferred_build_mode=unknown ;; esac
{
  echo "timestamp=$stamp"
  echo "nro=$NRO"
  echo "nro_mtime=$(stat -f %m "$NRO")"
  echo "nro_sha256=$actual_nro_sha"
  echo "nro_build_info=$BUILD_INFO"
  echo "switch_emulator=1"
  echo "warbell_revision=$(git -C "$ROOT_DIR" rev-parse HEAD 2>/dev/null || true)"
  echo "warbell_branch=$(git -C "$ROOT_DIR" branch --show-current 2>/dev/null || true)"
  echo "warbell_dirty_files=$(git -C "$ROOT_DIR" status --short 2>/dev/null | wc -l | tr -d ' ')"
  echo "wgpu29_revision=$(git -C "$ROOT_DIR/../wgpu-deko3d-29" rev-parse HEAD 2>/dev/null || true)"
  echo "wgpu29_branch=$(git -C "$ROOT_DIR/../wgpu-deko3d-29" branch --show-current 2>/dev/null || true)"
  echo "wgpu29_dirty_files=$(git -C "$ROOT_DIR/../wgpu-deko3d-29" status --short 2>/dev/null | wc -l | tr -d ' ')"
  echo "build_mode=${BUILD_MODE:-$inferred_build_mode}"
  echo "ryujinx_app=$RYUJINX_APP"
  echo "ryujinx_binary=$RYUJINX_APP/Contents/MacOS/Ryujinx"
  echo "ryujinx_binary_sha256=$(shasum -a 256 "$RYUJINX_APP/Contents/MacOS/Ryujinx" | awk '{print $1}')"
  echo "ryujinx_version=$(defaults read "$RYUJINX_APP/Contents/Info" CFBundleShortVersionString 2>/dev/null || true)"
  echo "launch_arguments=$NRO"
  echo "screenshot=$screenshot"
  echo "golden_screenshot=$GOLDEN_SCREENSHOT"
  echo "screenshot_regions=$SCREENSHOT_REGIONS"
  echo "required_log_pattern=$REQUIRED_LOG_PATTERN"
  echo "ready_timeout_seconds=$READY_TIMEOUT_SECONDS"
  echo "capture_delay_after_ready=$CAPTURE_DELAY_AFTER_READY"
  echo "capture_interval_seconds=$CAPTURE_INTERVAL_SECONDS"
  echo "capture_count=$CAPTURE_COUNT"
  echo "visual_check=$VISUAL_CHECK"
  echo "frame_profile=$FRAME_PROFILE"
  echo "keep_emulator_running=$KEEP_EMULATOR_RUNNING"
  echo "log=$log"
  echo "ryujinx_config=$HOME/Library/Application Support/Ryujinx/Config.json"
  echo "override_dir=$OVERRIDE_DIR"
  echo "diagnostic_overrides_allowed=$ALLOW_DIAGNOSTIC_OVERRIDES"
  if [ -f "$HOME/Library/Application Support/Ryujinx/Config.json" ]; then
    echo "ryujinx_config_sha256=$(shasum -a 256 "$HOME/Library/Application Support/Ryujinx/Config.json" | awk '{print $1}')"
  fi
  for f in "$OVERRIDE_DIR"/*.dksh; do
    [ -e "$f" ] || continue
    echo "override=$(basename "$f") sha256=$(shasum -a 256 "$f" | awk '{print $1}')"
  done
} > "$manifest"
echo "manifest=$manifest" | tee "$log"
"$RYUJINX_APP/Contents/MacOS/Ryujinx" "$NRO" >> "$log" 2>&1 &
pid=$!
sleep 1
kill -0 "$pid" 2>/dev/null || { echo "Ryujinx failed to start" | tee -a "$log" >&2; exit 1; }
echo "pid=$pid" | tee -a "$log" "$manifest"
failure_kind=
fatal_failure() {
  if grep -aEq 'PAL_SEHException|InvalidMemoryRegionException' "$log"; then
    echo pre_main_tls
  elif grep -aEq 'proof_artifact_lookup miss|shader_provider_(wgsl_hash|entry)_miss' "$log"; then
    echo shader_provider_miss
  elif grep -aiEq 'device lost' "$log"; then
    echo device_lost
  elif grep -aEq 'panicked at' "$log"; then
    echo guest_panic
  elif [ "$(grep -ac 'Unknown ThreadType struct version' "$log" || true)" -gt 100 ]; then
    echo emulator_log_storm
  fi
}

ready=0
elapsed=0
while [ "$elapsed" -lt "$READY_TIMEOUT_SECONDS" ]; do
  failure_kind=$(fatal_failure)
  [ -z "$failure_kind" ] || break
  kill -0 "$pid" 2>/dev/null || { failure_kind=early_exit; break; }
  if [ -z "$REQUIRED_LOG_PATTERN" ] || grep -aEq -- "$REQUIRED_LOG_PATTERN" "$log"; then
    ready=1
    break
  fi
  sleep 1
  elapsed=$((elapsed + 1))
done
if [ -z "$failure_kind" ] && [ "$ready" != 1 ]; then
  failure_kind=readiness_timeout
fi
echo "ready_elapsed_seconds=$elapsed" >> "$manifest"

visual_failures=0
if [ -z "$failure_kind" ] && [ "$VISUAL_CHECK" = 1 ]; then
  sleep "$CAPTURE_DELAY_AFTER_READY"
  capture=1
  while [ "$capture" -le "$CAPTURE_COUNT" ]; do
    kill -0 "$pid" 2>/dev/null || { failure_kind=early_exit; break; }
    window_id=$(swift "$ROOT_DIR/tools/find-macos-window-id.swift" "$pid" 2>> "$log" || true)
    if [ -z "$window_id" ]; then
      failure_kind=window_missing
      break
    fi
    frame=$(printf '%s/frame-%02d.png' "$run_dir" "$capture")
    report=$(printf '%s/frame-%02d.analysis.json' "$run_dir" "$capture")
    if ! screencapture -x -l "$window_id" "$frame" 2>> "$log" || [ ! -s "$frame" ]; then
      failure_kind=screenshot_capture
      break
    fi
    frame_sha=$(shasum -a 256 "$frame" | awk '{print $1}')
    echo "frame_${capture}=$frame sha256=$frame_sha window_id=$window_id" >> "$manifest"
    previous_args=
    if [ "$capture" -gt 1 ]; then
      previous_args=$(printf '%s/frame-%02d.png' "$run_dir" "$((capture - 1))")
    fi
    if [ -n "$previous_args" ]; then
      analysis_status=0
      uv run "$ROOT_DIR/tools/analyze-ryujinx-frame.py" \
        "$frame" --previous "$previous_args" --profile "$FRAME_PROFILE" --report "$report" \
        >> "$log" 2>&1 || analysis_status=$?
    else
      analysis_status=0
      uv run "$ROOT_DIR/tools/analyze-ryujinx-frame.py" \
        "$frame" --profile "$FRAME_PROFILE" --report "$report" >> "$log" 2>&1 || analysis_status=$?
    fi
    if [ "$analysis_status" = 0 ]; then
      echo "frame_${capture}_visual=passed report=$report" >> "$manifest"
    else
      visual_failures=$((visual_failures + 1))
      echo "frame_${capture}_visual=failed report=$report" >> "$manifest"
    fi
    cp "$frame" "$screenshot"
    capture=$((capture + 1))
    [ "$capture" -gt "$CAPTURE_COUNT" ] || sleep "$CAPTURE_INTERVAL_SECONDS"
  done
  if [ -z "$failure_kind" ] && [ "$visual_failures" -ne 0 ]; then
    failure_kind=visual_validation
  fi
fi

if [ -z "$failure_kind" ] && { [ -n "$GOLDEN_SCREENSHOT" ] || [ -n "$SCREENSHOT_REGIONS" ]; }; then
  if [ -z "$GOLDEN_SCREENSHOT" ] || [ ! -f "$GOLDEN_SCREENSHOT" ] || \
     [ -z "$SCREENSHOT_REGIONS" ] || [ ! -f "$SCREENSHOT_REGIONS" ]; then
    failure_kind=screenshot_configuration
  else
    [ -n "$SCREENSHOT_REPORT" ] || SCREENSHOT_REPORT=$run_dir/golden-comparison.json
    if uv run "$ROOT_DIR/tools/compare-ryujinx-screenshot.py" \
      "$screenshot" "$GOLDEN_SCREENSHOT" --regions "$SCREENSHOT_REGIONS" \
      --report "$SCREENSHOT_REPORT" >> "$log" 2>&1; then
      echo "screenshot_comparison=passed" >> "$manifest"
      echo "screenshot_report=$SCREENSHOT_REPORT" >> "$manifest"
    else
      failure_kind=screenshot_comparison
      echo "screenshot_comparison=failed" >> "$manifest"
      echo "screenshot_report=$SCREENSHOT_REPORT" >> "$manifest"
    fi
  fi
fi

[ -n "$failure_kind" ] || failure_kind=$(fatal_failure)
echo "log_sha256=$(shasum -a 256 "$log" | awk '{print $1}')" >> "$manifest"
echo "log_bytes=$(stat -f %z "$log")" >> "$manifest"
if [ -n "$failure_kind" ]; then
  echo "health=failed" >> "$manifest"
  echo "failure_kind=$failure_kind" >> "$manifest"
  echo "health check failed ($failure_kind); inspect $log" >> "$log"
  echo "run_dir=$run_dir"
  echo "log=$log"
  exit 1
fi
echo "health=passed" >> "$manifest"
if [ "$KEEP_EMULATOR_RUNNING" = 1 ]; then
  echo "emulator_cleanup=retained" >> "$manifest"
else
  echo "emulator_cleanup=automatic" >> "$manifest"
fi
echo "run_dir=$run_dir"
echo "log=$log"
echo "manifest=$manifest"
