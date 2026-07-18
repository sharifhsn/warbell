#!/usr/bin/env sh
set -eu

ROOT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
DEVKITPRO=${DEVKITPRO:-/tmp/devkitpro-switch1/opt/devkitpro}
SWITCH_REPO=${SWITCH_REPO:-$ROOT_DIR/../switch}
LOG_DIR=${LOG_DIR:-$ROOT_DIR/target/switch-nro/hardware-acceptance}
VISUAL_RESULT=${SWITCH_VISUAL_RESULT:-not_recorded}

if [ "$#" -ne 2 ]; then
  echo "usage: $0 <probe|compute> <switch-ip>" >&2
  exit 2
fi

TEST_KIND=$1
SWITCH_IP=$2
case "$TEST_KIND" in
  probe|compute) ;;
  *) echo "first argument must be probe or compute" >&2; exit 2 ;;
esac
case "$VISUAL_RESULT" in
  passed|failed|not_recorded) ;;
  *) echo "SWITCH_VISUAL_RESULT must be passed, failed, or not_recorded" >&2; exit 2 ;;
esac

NXLINK="$DEVKITPRO/tools/bin/nxlink"
if [ ! -x "$NXLINK" ]; then
  echo "missing nxlink: $NXLINK" >&2
  echo "bootstrap devkitPro with ../switch/experiments/switch1-deko3d-wgpu/tools/bootstrap-devkitpro-switch.sh" >&2
  exit 1
fi

case "$TEST_KIND" in
  probe)
    NRO=${NRO:-$ROOT_DIR/target/switch-nro/probe/cargo-target/horizon-newlib-gcc/debug/warbell-switch.nro}
    BUILD_INFO="$NRO.build-info.txt"
    if [ ! -f "$BUILD_INFO" ]; then
      echo "missing physical-build metadata: $BUILD_INFO" >&2
      exit 1
    fi
    [ "$(awk -F= '$1 == "switch_app" { print $2 }' "$BUILD_INFO")" = probe ] || {
      echo "Warbell NRO is not a probe build" >&2
      exit 1
    }
    [ "$(awk -F= '$1 == "switch_emulator" { print $2 }' "$BUILD_INFO")" = 0 ] || {
      echo "refusing an emulator-mode Warbell NRO for physical acceptance" >&2
      exit 1
    }
    EXPECTED_WGPU=$(git -C "$ROOT_DIR/vendor/wgpu" rev-parse HEAD)
    [ "$(awk -F= '$1 == "wgpu" { print $2 }' "$BUILD_INFO")" = "$EXPECTED_WGPU" ] || {
      echo "Warbell NRO was not built from current wgpu $EXPECTED_WGPU" >&2
      exit 1
    }
    EXPECTED_WARBELL=$(git -C "$ROOT_DIR" rev-parse HEAD)
    [ "$(awk -F= '$1 == "warbell" { print $2 }' "$BUILD_INFO")" = "$EXPECTED_WARBELL" ] || {
      echo "Warbell NRO was not built from current Warbell $EXPECTED_WARBELL" >&2
      exit 1
    }
    ;;
  compute)
    NRO=${NRO:-$SWITCH_REPO/target/wgpu-public-runtime-compute/cargo-target/horizon-newlib-gcc/debug/deko-wgpu-public-runtime-compute-rs.nro}
    ;;
esac

if [ ! -f "$NRO" ]; then
  echo "missing NRO: $NRO" >&2
  exit 1
fi

if [ "$TEST_KIND" = compute ]; then
  NRO_MTIME=$(stat -f '%m' "$NRO")
  WGPU_COMMIT_TIME=$(git -C "$ROOT_DIR/vendor/wgpu" show -s --format='%ct' HEAD)
  COMPILER_COMMIT_TIME=$(git -C "$ROOT_DIR/vendor/deko-shader-compiler" show -s --format='%ct' HEAD)
  if [ "$NRO_MTIME" -lt "$WGPU_COMMIT_TIME" ] || [ "$NRO_MTIME" -lt "$COMPILER_COMMIT_TIME" ]; then
    echo "compute NRO predates the current wgpu or compiler commit; rebuild it first" >&2
    exit 1
  fi
fi

mkdir -p "$LOG_DIR"
STAMP=$(date -u +%Y%m%dT%H%M%SZ)
RUN_DIR="$LOG_DIR/$STAMP-$TEST_KIND"
RUN_SUFFIX=1
while [ -e "$RUN_DIR" ]; do
  RUN_DIR="$LOG_DIR/$STAMP-$TEST_KIND-$RUN_SUFFIX"
  RUN_SUFFIX=$((RUN_SUFFIX + 1))
done
mkdir -p "$RUN_DIR"
LOG="$RUN_DIR/nxlink.log"
MANIFEST="$RUN_DIR/run.manifest"
NRO_SHA256=$(shasum -a 256 "$NRO" | awk '{ print $1 }')
WARBELL_REV=$(git -C "$ROOT_DIR" rev-parse HEAD)
WGPU_REV=$(git -C "$ROOT_DIR/vendor/wgpu" rev-parse HEAD)
COMPILER_REV=$(git -C "$ROOT_DIR/vendor/deko-shader-compiler" rev-parse HEAD)

{
  echo "test_kind=$TEST_KIND"
  echo "started_utc=$STAMP"
  echo "switch_ip=$SWITCH_IP"
  echo "nro=$NRO"
  echo "nro_sha256=$NRO_SHA256"
  echo "warbell=$WARBELL_REV"
  echo "wgpu=$WGPU_REV"
  echo "deko_shader_compiler=$COMPILER_REV"
  echo "visual_result=$VISUAL_RESULT"
  echo "automated_health=pending"
  echo "completion_health=pending"
} > "$MANIFEST"

echo "Sending $TEST_KIND NRO to $SWITCH_IP"
echo "Log: $LOG"
echo "Manifest: $MANIFEST"
"$NXLINK" -s -a "$SWITCH_IP" "$NRO" 2>&1 | tee "$LOG"

if "$ROOT_DIR/tools/validate-switch-hardware-log.sh" "$TEST_KIND" "$LOG"; then
  AUTOMATED_HEALTH=passed
else
  AUTOMATED_HEALTH=failed
fi

COMPLETION_HEALTH=$AUTOMATED_HEALTH
if [ "$TEST_KIND" = probe ]; then
  if [ "$VISUAL_RESULT" = failed ]; then
    COMPLETION_HEALTH=failed
  elif [ "$VISUAL_RESULT" != passed ] && [ "$AUTOMATED_HEALTH" = passed ]; then
    COMPLETION_HEALTH=pending_visual
  fi
fi

TMP_MANIFEST="$MANIFEST.tmp"
awk -v automated="$AUTOMATED_HEALTH" -v completion="$COMPLETION_HEALTH" '
  $1 == "automated_health=pending" { print "automated_health=" automated; next }
  $1 == "completion_health=pending" { print "completion_health=" completion; next }
  { print }
' "$MANIFEST" > "$TMP_MANIFEST"
mv "$TMP_MANIFEST" "$MANIFEST"

echo "automated_health=$AUTOMATED_HEALTH completion_health=$COMPLETION_HEALTH"
[ "$COMPLETION_HEALTH" = passed ]
