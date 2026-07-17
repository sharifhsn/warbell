# Deko3D debugging

## Canonical Ryujinx run

Build Warbell, then launch it with:

```sh
SWITCH_EMULATOR=1 bash tools/build-switch-nro.sh
RYUJINX_APP=../switch/target/ryujinx-d3-fixed/bundle/Ryujinx.app \
  tools/run-ryujinx-warbell.sh
```

The build reuses its cross-target cache by default. Set `CLEAN_BUILD=1` only
when validating a cold toolchain rebuild; routine shader and backend iterations
should remain incremental.

The runner kills stale Ryujinx instances, hashes the NRO, rejects unsafe shader
overrides, and records repository, emulator binary, configuration, and launch
metadata. It waits for guest readiness, captures three exact-PID window frames,
validates canonical game runs against `tools/warbell-game-frame-profile.json`
and renderer-probe runs against `tools/warbell-frame-profile.json`, verifies that
captured content advances, and terminates the emulator on every exit path. Each
run gets an isolated directory under `target/ryujinx-logs` containing the log,
manifest, screenshots, and machine-readable visual reports.

By default the runner requires Warbell's single-line frame-60 acceptance marker
within 75 seconds. A successful manifest reports `health=passed`; process
survival alone is never success.
Keep readiness markers as complete static strings. The libnx debug console can
emit Rust formatting arguments as separate `OutputDebugString` records, so a
single regex cannot reliably match a prefix and its formatted numeric value.
Specialized diagnostics may override `REQUIRED_LOG_PATTERN` only with
`ALLOW_CUSTOM_READINESS=1`, and may override `FRAME_PROFILE` only with
`ALLOW_CUSTOM_FRAME_PROFILE=1`; both choices are recorded in the manifest.
`READY_TIMEOUT_SECONDS`, `CAPTURE_DELAY_AFTER_READY`,
`CAPTURE_INTERVAL_SECONDS`, and `CAPTURE_COUNT` control timing. Set
`VISUAL_CHECK=0` only for an explicit nonvisual diagnostic, or
`KEEP_EMULATOR_RUNNING=1` when interactive inspection is required. A missing
signature, missing window, black or underlit scene, frozen capture sequence, or
failed screenshot capture fails the run even if Ryujinx remains alive. The
runner also classifies repeated `Unknown ThreadType struct version` messages as
an emulator log storm instead of allowing the log to grow without bound.

The sibling Switch harness owns the reproducible patched-emulator build. Its
`build-ryujinx-d3-fixed.sh` applies the pinned DMA `RegionZ` fix without enabling
per-command logs and prevents failed guest thread-name discovery from becoming
a scheduler-rate warning storm.

Diagnostic shader overrides are disabled by default. A deliberate diagnostic
run must set `ALLOW_DIAGNOSTIC_OVERRIDES=1`; diagnostic manifests expire after
24 hours unless `ALLOW_EXPIRED_OVERRIDES=1` is also set.

## Shader overrides

Install an override with:

```sh
tools/install-dksh-override.sh shader.wgsl fragment main main \
  REQUEST_SHA256 EXPECTED_ORIGINAL_REFLECTION_SHA256 diagnostic
```

The installer emits the artifact, reflection, and a manifest containing source,
artifact, and reflection hashes plus the complete binding map. Warbell verifies
the manifest and artifact hash again inside the guest before loading it.

For the captured Bevy PBR fragment, prefer production-shaped function probes:

```sh
tools/build-pbr-function-diagnostics.sh \
  lut-bypass lut-fixed-center lut-input-coordinates lut-nearest-load
```

These replace only one named WGSL function body and retain the real fragment
entry point, PBR decode, lighting, and post-processing flow. The older
`build-full-pbr-diagnostics.sh` entry-point variants remain useful for coarse
isolation, but they deliberately produce much smaller shaders and are not the
first choice for emulator debugging. Install a compiled function probe with
`PREBUILT_DKSH` and `PREBUILT_REFLECTION` so it keeps the binding targets emitted
by the diagnostic builder.

## Texture probe

The Switch harness contains a small D3 sampled-texture probe at
`experiments/switch1-deko3d-wgpu/examples/deko-wgpu-public-texture3d-rs` in the
sibling `switch` repository. Build it for Ryujinx with `SWITCH_EMULATOR=1`; omitting
that flag uses hardware TLS and causes a pre-main `PAL_SEHException` in Ryujinx.

The probe validates a 48-case sampled-texture matrix: 2D, 2D-array, cube, and
3D views; `Rgba8Unorm`, `Rgba16Float`, and `Rgb9e5Ufloat`; tight and 256-byte
padded uploads; and nearest and linear sampling. Every case renders offscreen,
copies the result back to a buffer, and compares an exact expected center color.
The procedural payload encodes X, Y, and Z independently, so the D3 cases catch
axis swaps and repeated or misplaced slices rather than validating only row data.
It also validates padded D3 upload/readback, `textureLoad`, a real Tony-sized
48x48x48 LUT, a real AgX 32x32x32 LUT, and a mixed binding layout with the D3
texture at native target 2.
On failure it explicitly dumps the bounded Deko3D resource trace.
On Switch or in Ryujinx, pressing Plus and Minus together dumps the same trace
on demand. Emulator builds also dump it once at frame 300 so deterministic runs
capture resource and native-binding records without enabling per-draw logging.

## Runtime WGSL compute probe

The sibling `switch` repository contains the provider-free acceptance app at
`experiments/switch1-deko3d-wgpu/examples/deko-wgpu-public-runtime-compute-rs`.
Always build the emulator form explicitly:

```sh
cd ../switch
SWITCH_EMULATOR=1 \
  experiments/switch1-deko3d-wgpu/tools/build-wgpu-public-runtime-compute.sh
```

Without `SWITCH_EMULATOR=1`, the NRO uses hardware TLS and can fail before `main` in
Ryujinx. The acceptance app must not install a DKSH provider: it exercises ordinary
WGSL through the compiler embedded by wgpu's `deko3d` feature.

The current patched Ryujinx run proves pipeline creation, binding, dispatch command
submission, and the separate buffer-copy/readback path. Compute output remains zero
for both compiler-produced DKSH and an official UAM-produced artifact, so do not treat
that emulator result as a compiler-codegen failure. Use physical Switch readback as
the authoritative compute semantic test.

## Screenshot comparison

The canonical run always performs profile-based validation. The checked-in
profile uses normalized regions and color/luminance ranges, so it tolerates
window-size changes while rejecting the known black and underlit failures. The
second and later captures must also differ from their predecessor, which catches
a visually plausible but frozen presentation.

An exact golden comparison remains available for tighter regression tests.

Compare a deterministic capture against a golden image with:

```sh
rtk uv run tools/compare-ryujinx-screenshot.py actual.png golden.png \
  --regions tools/warbell-screenshot-regions.example.json \
  --report target/screenshot-report.json
```

The report includes per-region RMS error, changed-pixel fraction, mean colors,
and a pass/fail result.

The canonical runner can perform the comparison automatically:

```sh
GOLDEN_SCREENSHOT=tools/goldens/warbell.png \
SCREENSHOT_REGIONS=tools/warbell-screenshot-regions.example.json \
  tools/run-ryujinx-warbell.sh
```

Inspect the exact CPU-side payload of either embedded Bevy LUT with:

```sh
rtk uv run --script tools/inspect-ktx2-lut.py path/to/lut.ktx2
```

For AgX failures, `compare-agx-lut-stage.py` takes a screenshot from the
`lut-input-coordinates` probe and an untouched-PBR screenshot, reconstructs the
expected result from Bevy's KTX2 LUT, and reports pixel error. This distinguishes
a bad texture sample from valid LUT behavior driven by bad or underexposed input.

The Switch acceptance scene explicitly uses a 1000 cd/m2 global ambient light.
Without it, the vertical walls receive only the default low ambient term; their
valid AgX coordinates land near the black end of the LUT and make a correct PBR
render look like a texture failure.
