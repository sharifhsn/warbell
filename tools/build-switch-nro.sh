#!/usr/bin/env sh
set -eu

ROOT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
SWITCH_REPO=${SWITCH_REPO:-"$ROOT_DIR/../switch"}
DEVKITPRO=${DEVKITPRO:-/tmp/devkitpro-switch1/opt/devkitpro}
DEVKITA64=${DEVKITA64:-$DEVKITPRO/devkitA64}
TARGET_JSON=${TARGET_JSON:-"$SWITCH_REPO/experiments/switch1-deko3d-wgpu/targets/aarch64-nintendo-switch-horizon-newlib.json"}
PATCH_DIR=${PATCH_DIR:-"$SWITCH_REPO/experiments/switch1-deko3d-wgpu/dependency-patches"}
OUT_ROOT=${OUT_ROOT:-"$ROOT_DIR/target/switch-nro"}
LIBNX_FILTERED="$OUT_ROOT/libnx.a"
CLEAN_BUILD=${CLEAN_BUILD:-1}
GENERATED_TARGET="$OUT_ROOT/horizon-newlib-gcc.json"
DEPS_DIR="$OUT_ROOT/deps"
ROMFS_STAGE="$OUT_ROOT/romfs"
CARGO_TARGET_DIR="$OUT_ROOT/cargo-target"
OUT_DIR="$CARGO_TARGET_DIR/horizon-newlib-gcc/debug"
OUT_ELF="$OUT_DIR/tileworld_bevy_forest"
OUT_NACP="$OUT_DIR/tileworld_bevy_forest.nacp"
OUT_NRO="$OUT_DIR/warbell-switch.nro"
CARGO_HOME=${CARGO_HOME:-"$HOME/.cargo"}

export DEVKITPRO DEVKITA64 CARGO_TARGET_DIR
export PATH="$DEVKITPRO/tools/bin:$DEVKITA64/bin:$PATH"

require_command() {
  if ! command -v "$1" >/dev/null 2>&1; then
    echo "missing required command: $1" >&2
    exit 1
  fi
}

require_file() {
  if [ ! -f "$1" ]; then
    echo "missing required file: $1" >&2
    exit 1
  fi
}

find_registry_crate_source() {
  crate=$1
  version=$2
  source=$(find "$CARGO_HOME/registry/src" -type d -name "$crate-$version" -print -quit)
  if [ -z "$source" ]; then
    echo "missing locked crate source: $crate-$version" >&2
    exit 1
  fi
  printf '%s\n' "$source"
}

locked_version() {
  awk -v crate="$1" '
    $0 == "[[package]]" { name = ""; version = ""; next }
    $1 == "name" { name = $3; gsub(/"/, "", name) }
    $1 == "version" { version = $3; gsub(/"/, "", version) }
    name == crate && version != "" { print version; exit }
  ' "$ROOT_DIR/Cargo.lock"
}

copy_crate() {
  rm -rf "$2"
  cp -R "$1" "$2"
  chmod -R u+w "$2"
}

patch_libc_horizon() {
  require_file "$PATCH_DIR/0001-libc-horizon-newlib-rustix-surface.patch"
  perl -0pi -e 's/pub type clockid_t = c_ulong;/cfg_if! {\n    if #[cfg(target_os = "horizon")] {\n        pub type clockid_t = c_int;\n    } else {\n        pub type clockid_t = c_ulong;\n    }\n}/' "$LIBC_PATCHED/src/unix/newlib/mod.rs"
  perl -0pi -e 's/pub events: c_int,\n        pub revents: c_int,/pub events: c_short,\n        pub revents: c_short,/' "$LIBC_PATCHED/src/unix/newlib/horizon/mod.rs"
  perl -0pi -e 's/pub const POLLIN: c_int = 0x0001;\npub const POLLPRI: c_int = 0x0002;\npub const POLLOUT: c_int = 0x0004;\npub const POLLRDNORM: c_int = 0x0040;\npub const POLLWRNORM: c_int = POLLOUT;\npub const POLLRDBAND: c_int = 0x0080;\npub const POLLWRBAND: c_int = 0x0100;\npub const POLLERR: c_int = 0x0008;\npub const POLLHUP: c_int = 0x0010;\npub const POLLNVAL: c_int = 0x0020;/pub const POLLIN: c_short = 0x0001;\npub const POLLPRI: c_short = 0x0002;\npub const POLLOUT: c_short = 0x0004;\npub const POLLRDNORM: c_short = 0x0040;\npub const POLLWRNORM: c_short = POLLOUT;\npub const POLLRDBAND: c_short = 0x0080;\npub const POLLWRBAND: c_short = 0x0100;\npub const POLLERR: c_short = 0x0008;\npub const POLLHUP: c_short = 0x0010;\npub const POLLNVAL: c_short = 0x0020;/' "$LIBC_PATCHED/src/unix/newlib/horizon/mod.rs"
  perl -0pi -e 's/    pub fn gethostid\(\) -> c_long;\n/    pub fn gethostid() -> c_long;\n\n    pub fn dirfd(dirp: *mut crate::DIR) -> c_int;\n\n    pub fn seekdir(dirp: *mut crate::DIR, loc: c_long);\n/' "$LIBC_PATCHED/src/unix/newlib/horizon/mod.rs"
  grep -q 'pub type clockid_t = c_int' "$LIBC_PATCHED/src/unix/newlib/mod.rs"
  grep -q 'pub events: c_short' "$LIBC_PATCHED/src/unix/newlib/horizon/mod.rs"
  grep -q 'pub const POLLIN: c_short' "$LIBC_PATCHED/src/unix/newlib/horizon/mod.rs"
  grep -q 'pub fn dirfd' "$LIBC_PATCHED/src/unix/newlib/horizon/mod.rs"
  grep -q 'pub fn seekdir' "$LIBC_PATCHED/src/unix/newlib/horizon/mod.rs"
}

patch_polling_horizon() {
  require_file "$PATCH_DIR/0002-polling-use-pipe-fallback-on-horizon.patch"
  perl -0pi -e 's/not\(any\(target_os = "haiku", target_os = "nto"\)\)/not(any(target_os = "haiku", target_os = "horizon", target_os = "nto"))/g; s/any\(target_os = "haiku", target_os = "nto"\)/any(target_os = "haiku", target_os = "horizon", target_os = "nto")/g' "$POLLING_PATCHED/src/poll.rs"
  grep -q 'target_os = "horizon"' "$POLLING_PATCHED/src/poll.rs"
}

require_command cargo
require_command jq
require_command perl
require_command aarch64-none-elf-gcc
require_command aarch64-none-elf-ar
require_command aarch64-none-elf-nm
require_command nacptool
require_command elf2nro
require_file "$ROOT_DIR/Cargo.lock"
require_file "$TARGET_JSON"

LIBC_VERSION=$(locked_version libc)
POLLING_VERSION=$(locked_version polling)
if [ -z "$LIBC_VERSION" ] || [ -z "$POLLING_VERSION" ]; then
  echo "could not derive libc/polling versions from Cargo.lock" >&2
  exit 1
fi
LIBC_SRC=$(find_registry_crate_source libc "$LIBC_VERSION")
POLLING_SRC=$(find_registry_crate_source polling "$POLLING_VERSION")
LIBC_PATCHED="$DEPS_DIR/libc-horizon-newlib"
POLLING_PATCHED="$DEPS_DIR/polling-horizon"

mkdir -p "$OUT_ROOT" "$DEPS_DIR"
if [ "$CLEAN_BUILD" = 1 ]; then
  rm -rf "$CARGO_TARGET_DIR"
fi
copy_crate "$LIBC_SRC" "$LIBC_PATCHED"
copy_crate "$POLLING_SRC" "$POLLING_PATCHED"
grep -q "^version = \"$LIBC_VERSION\"$" "$LIBC_PATCHED/Cargo.toml"
grep -q "^version = \"$POLLING_VERSION\"$" "$POLLING_PATCHED/Cargo.toml"
patch_libc_horizon
patch_polling_horizon

jq --arg linker "$DEVKITA64/bin/aarch64-none-elf-gcc" \
  'del(."link-script") | .linker = $linker | ."linker-flavor" = "gnu-cc"' \
  "$TARGET_JSON" > "$GENERATED_TARGET"

rm -rf "$ROMFS_STAGE"
mkdir -p "$ROMFS_STAGE"
cp -R "$ROOT_DIR/assets" "$ROMFS_STAGE/assets"
require_file "$ROMFS_STAGE/assets/shaders/terrain.wgsl"

# libnx's socket.o also exports fcntl, which conflicts with Newlib when the
# static linker pulls both archives. Warbell does not use libnx networking, so
# remove only that object and let Newlib provide fcntl. Deko3D still links this
# archive by its normal `-lnx` name through the earlier search path below.
cp "$DEVKITPRO/libnx/lib/libnx.a" "$LIBNX_FILTERED"
aarch64-none-elf-ar d "$LIBNX_FILTERED" socket.o
if aarch64-none-elf-nm -A "$LIBNX_FILTERED" | grep -q ' T fcntl$'; then
  echo "filtered libnx still exports fcntl" >&2
  exit 1
fi

GCC_VERSION=$(aarch64-none-elf-gcc -dumpfullversion -dumpversion)
GCC_LIB="$DEVKITA64/lib/gcc/aarch64-none-elf/$GCC_VERSION"
require_file "$DEVKITPRO/libnx/switch.specs"
require_file "$DEVKITPRO/libnx/lib/libnx.a"
require_file "$DEVKITA64/aarch64-none-elf/lib/pic/libsysbase.a"
require_file "$GCC_LIB/libgcc.a"

RUSTFLAGS='--cfg getrandom_backend="custom" --check-cfg=cfg(getrandom_backend,values("custom")) --check-cfg=cfg(target_os,values("dotnet"))'
RUSTFLAGS="$RUSTFLAGS -L native=$OUT_ROOT"
RUSTFLAGS="$RUSTFLAGS -L native=$DEVKITPRO/libnx/lib"
RUSTFLAGS="$RUSTFLAGS -L native=$DEVKITA64/aarch64-none-elf/lib/pic"
RUSTFLAGS="$RUSTFLAGS -L native=$GCC_LIB/pic"
RUSTFLAGS="$RUSTFLAGS -L native=$DEVKITA64/aarch64-none-elf/lib"
RUSTFLAGS="$RUSTFLAGS -L native=$GCC_LIB"
RUSTFLAGS="$RUSTFLAGS -C link-arg=-specs=$DEVKITPRO/libnx/switch.specs"
RUSTFLAGS="$RUSTFLAGS -C link-arg=-Wl,--start-group"
RUSTFLAGS="$RUSTFLAGS -C link-arg=-lpthread"
RUSTFLAGS="$RUSTFLAGS -C link-arg=-lsysbase"
RUSTFLAGS="$RUSTFLAGS -C link-arg=-lc"
RUSTFLAGS="$RUSTFLAGS -C link-arg=-lm"
RUSTFLAGS="$RUSTFLAGS -C link-arg=-lgcc"
RUSTFLAGS="$RUSTFLAGS -C link-arg=-Wl,--end-group"
export RUSTFLAGS

cd "$ROOT_DIR"
cargo +nightly build --offline \
  --config "patch.crates-io.libc.path='$LIBC_PATCHED'" \
  --config "patch.crates-io.polling.path='$POLLING_PATCHED'" \
  --no-default-features --features switch \
  --target "$GENERATED_TARGET" \
  -Z json-target-spec -Z build-std=std,panic_abort

require_file "$OUT_ELF"
nacptool --create Warbell miskibin 0.20.0 "$OUT_NACP"
elf2nro "$OUT_ELF" "$OUT_NRO" --nacp="$OUT_NACP" --romfsdir="$ROMFS_STAGE"
require_file "$OUT_NRO"
echo "built $OUT_NRO"
