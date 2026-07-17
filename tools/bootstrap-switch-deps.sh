#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR=$(cd "$(dirname "$0")/.." && pwd)

bootstrap_fork() {
  local destination=$1
  local remote=$2
  local upstream=$3
  local branch=$4

  if [[ -d "$destination/.git" ]]; then
    git -C "$destination" remote set-url origin "$remote"
    if [[ -n "$upstream" ]]; then
      git -C "$destination" remote set-url upstream "$upstream" 2>/dev/null || git -C "$destination" remote add upstream "$upstream"
    fi
  else
    git clone "$remote" "$destination"
    if [[ -n "$upstream" ]]; then
      git -C "$destination" remote add upstream "$upstream"
    fi
  fi

  if git -C "$destination" show-ref --verify --quiet "refs/heads/$branch"; then
    git -C "$destination" checkout "$branch"
  elif git -C "$destination" ls-remote --exit-code origin "refs/heads/$branch" >/dev/null; then
    git -C "$destination" fetch origin "$branch"
    git -C "$destination" checkout --track "origin/$branch"
  else
    printf 'required branch %s has not been published to %s\n' "$branch" "$remote" >&2
    exit 1
  fi
}

mkdir -p "$ROOT_DIR/vendor"
bootstrap_fork "$ROOT_DIR/vendor/wgpu" "https://github.com/sharifhsn/wgpu.git" "https://github.com/gfx-rs/wgpu.git" "codex/deko3d-wgpu29"
bootstrap_fork "$ROOT_DIR/vendor/bevy" "https://github.com/sharifhsn/bevy.git" "https://github.com/bevyengine/bevy.git" "codex/deko3d-horizon"
bootstrap_fork "$ROOT_DIR/vendor/deko-shader-compiler" "https://github.com/sharifhsn/deko-shader-compiler.git" "" "main"
