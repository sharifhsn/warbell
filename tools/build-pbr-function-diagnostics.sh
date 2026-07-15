#!/usr/bin/env sh
set -eu

ROOT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
SWITCH_REPO=${SWITCH_REPO:-"$ROOT_DIR/../switch"}
SOURCE=${PBR_WGSL_SOURCE:-"$HOME/Library/Application Support/Ryujinx/sdcard/switch/warbell-shaders/6a4df609aa00f61c5f99ff312d0a1a241ccf11d26b30645f10ac53c00bc49647-fragment-main.wgsl"}
VARIANT_DIR="$ROOT_DIR/tools/shader-variants/pbr-functions"
OUT_DIR=${PBR_FUNCTION_DIAGNOSTIC_OUT_DIR:-"$ROOT_DIR/target/pbr-function-variants"}

[ -f "$SOURCE" ] || { echo "missing captured PBR WGSL: $SOURCE" >&2; exit 1; }
mkdir -p "$OUT_DIR"

if [ "$#" -eq 0 ]; then
  set -- "$VARIANT_DIR"/*.wgsl-body
else
  requested=
  for name in "$@"; do
    match=$(find "$VARIANT_DIR" -maxdepth 1 -type f -name "*--$name.wgsl-body" -print)
    [ -n "$match" ] || { echo "unknown PBR function diagnostic: $name" >&2; exit 2; }
    [ "$(printf '%s\n' "$match" | wc -l | tr -d ' ')" -eq 1 ] || {
      echo "ambiguous PBR function diagnostic: $name" >&2
      exit 2
    }
    requested="$requested $match"
  done
  set -- $requested
fi

for body in "$@"; do
  [ -f "$body" ] || { echo "unknown PBR function diagnostic: $body" >&2; exit 2; }
  stem=$(basename "$body" .wgsl-body)
  function=${stem%%--*}
  name=${stem#*--}
  [ "$function" != "$stem" ] || {
    echo "diagnostic name must be FUNCTION--NAME: $stem" >&2
    exit 2
  }
  wgsl="$OUT_DIR/$name.wgsl"
  rtk uv run "$ROOT_DIR/tools/replace-wgsl-entry-body.py" \
    --input "$SOURCE" --entry "$function" --body "$body" --output "$wgsl"
  cargo run --manifest-path "$SWITCH_REPO/Cargo.toml" -p wgsl-to-dksh -- \
    --stage fragment --entry fragment --input "$wgsl" \
    --coordinate-space adjusted --auto-bind-resources \
    --bind 2:0=6 --bind 0:0=0 --bind 0:1=1 --bind 0:8=2 \
    --bind 0:9=3 --bind 0:10=4 --bind 0:2=0 --bind 0:3=0 \
    --bind 0:5=1 --bind 0:6=1 --bind 0:11=5 --bind 0:18=2 \
    --bind 0:19=2 --bind 3:0=7 --bind 3:1=3 --bind 3:2=3 \
    --bind 3:3=4 --bind 3:4=4 --bind 3:5=5 --bind 3:6=5 \
    --bind 3:7=6 --bind 3:8=6 \
    --glsl-out "$OUT_DIR/$name.glsl" \
    --dksh-out "$OUT_DIR/$name.dksh" \
    --uam-raw-out "$OUT_DIR/$name.raw" \
    --uam-tgsi-out "$OUT_DIR/$name.tgsi" \
    --reflection-out "$OUT_DIR/$name.reflection.json" \
    --artifact-out "$OUT_DIR/$name.artifact.json"
done

echo "built production-shaped PBR diagnostics in $OUT_DIR"
