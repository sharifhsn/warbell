#!/usr/bin/env sh
set -eu

if [ "$#" -ne 7 ]; then
  echo "usage: $0 <wgsl> <vertex|fragment|compute> <compile-entry> <request-entry> <request-sha256> <expected-original-reflection-sha256> <diagnostic|production>" >&2
  exit 2
fi

ROOT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
SWITCH_REPO=${SWITCH_REPO:-"$ROOT_DIR/../switch"}
RYUJINX_SD_ROOT=${RYUJINX_SD_ROOT:-"$HOME/Library/Application Support/Ryujinx/sdcard"}
INPUT=$1
STAGE=$2
COMPILE_ENTRY=$3
REQUEST_ENTRY=$4
REQUEST_HASH=$5
EXPECTED_REFLECTION_HASH=$6
DESIGNATION=$7
COORDINATE_SPACE=${COORDINATE_SPACE:-native}
MULTIVIEW_MASK=${MULTIVIEW_MASK:-}
MULTIVIEW_FLAG=
MULTIVIEW_JSON=null

case "$STAGE" in
  vertex|fragment|compute) ;;
  *) echo "invalid shader stage: $STAGE" >&2; exit 2 ;;
esac
case "$REQUEST_HASH" in
  *[!0-9a-f]*|'') echo "request SHA-256 must be 64 lowercase hex characters" >&2; exit 2 ;;
esac
if [ "${#REQUEST_HASH}" -ne 64 ]; then
  echo "request SHA-256 must be 64 lowercase hex characters" >&2
  exit 2
fi
case "$EXPECTED_REFLECTION_HASH" in
  *[!0-9a-f]*|'') echo "expected reflection SHA-256 must be 64 lowercase hex characters" >&2; exit 2 ;;
esac
if [ "${#EXPECTED_REFLECTION_HASH}" -ne 64 ]; then
  echo "expected reflection SHA-256 must be 64 lowercase hex characters" >&2; exit 2
fi
case "$DESIGNATION" in diagnostic|production) ;; *) echo "designation must be diagnostic or production" >&2; exit 2 ;; esac
if [ -n "$MULTIVIEW_MASK" ]; then
  case "$MULTIVIEW_MASK" in *[!0-9]*|0|'') echo "MULTIVIEW_MASK must be a positive decimal u32" >&2; exit 2 ;; esac
  [ "$STAGE" = vertex ] || { echo "MULTIVIEW_MASK is only valid for vertex shaders" >&2; exit 2; }
  MULTIVIEW_FLAG=--multiview
  MULTIVIEW_JSON=$MULTIVIEW_MASK
fi
if [ ! -f "$INPUT" ]; then
  echo "missing WGSL input: $INPUT" >&2
  exit 2
fi

SAFE_ENTRY=$(printf '%s' "$REQUEST_ENTRY" | tr -c 'A-Za-z0-9_' '_')
NAME="$REQUEST_HASH-$STAGE-$SAFE_ENTRY"
if [ -n "$MULTIVIEW_MASK" ]; then NAME="$NAME-mv$MULTIVIEW_MASK"; fi
OUT_DIR="$ROOT_DIR/target/dksh-overrides/$NAME"
INSTALL_DIR="$RYUJINX_SD_ROOT/switch/warbell-shader-overrides"
TOOL_MANIFEST="$SWITCH_REPO/Cargo.toml"

mkdir -p "$OUT_DIR" "$INSTALL_DIR"
if [ -n "${PREBUILT_DKSH:-}" ] || [ -n "${PREBUILT_REFLECTION:-}" ]; then
  [ -f "${PREBUILT_DKSH:-}" ] && [ -f "${PREBUILT_REFLECTION:-}" ] || {
    echo "PREBUILT_DKSH and PREBUILT_REFLECTION must both name files" >&2
    exit 2
  }
  cp "$PREBUILT_DKSH" "$OUT_DIR/shader.dksh"
  cp "$PREBUILT_REFLECTION" "$OUT_DIR/shader.reflection.json"
else
  cargo run --manifest-path "$TOOL_MANIFEST" -p wgsl-to-dksh -- \
    --stage "$STAGE" \
    --entry "$COMPILE_ENTRY" \
    --input "$INPUT" \
    --coordinate-space "$COORDINATE_SPACE" \
    $MULTIVIEW_FLAG \
    --auto-bind-resources \
    --glsl-out "$OUT_DIR/shader.glsl" \
    --dksh-out "$OUT_DIR/shader.dksh" \
    --uam-raw-out "$OUT_DIR/shader.raw" \
    --uam-tgsi-out "$OUT_DIR/shader.tgsi" \
    --reflection-out "$OUT_DIR/shader.reflection.json" \
    --artifact-out "$OUT_DIR/shader.artifact.json"
fi
cp "$OUT_DIR/shader.dksh" "$INSTALL_DIR/$NAME.dksh"
cp "$OUT_DIR/shader.reflection.json" "$INSTALL_DIR/$NAME.reflection.json"
sha256_file() {
  if command -v shasum >/dev/null 2>&1; then shasum -a 256 "$1" | awk '{print $1}'; else sha256sum "$1" | awk '{print $1}'; fi
}
cat > "$INSTALL_DIR/$NAME.json" <<EOF
{
  "request_sha256": "$REQUEST_HASH",
  "source_sha256": "$(sha256_file "$INPUT")",
  "artifact_sha256": "$(sha256_file "$OUT_DIR/shader.dksh")",
  "reflection_sha256": "$(sha256_file "$OUT_DIR/shader.reflection.json")",
  "expected_original_reflection_sha256": "$EXPECTED_REFLECTION_HASH",
  "stage": "$STAGE",
  "compile_entry": "$COMPILE_ENTRY",
  "request_entry": "$REQUEST_ENTRY",
  "created_at": "$(date -u +%Y-%m-%dT%H:%M:%SZ)",
  "designation": "$DESIGNATION",
  "coordinate_space": "$COORDINATE_SPACE",
  "multiview_mask": $MULTIVIEW_JSON,
  "binding_map_targets": $(jq -c '[.resources[] | {group, binding, kind, binding_map_target}]' "$OUT_DIR/shader.reflection.json")
}
EOF
echo "installed $INSTALL_DIR/$NAME.dksh"
