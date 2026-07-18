# Warbell Switch Port Handoff

Last updated: 2026-07-18

## Goal

Run the Bevy 0.19 Warbell game on Nintendo Switch through an experimental Deko3D backend while keeping the active implementation on wgpu 29. The wgpu 30 fork is reference material only; do not transplant it or make the Switch port depend on it. Revisit an upgrade only when Bevy and the surrounding dependency stack move forward.

## Repository ownership

| Repository | Branch | Responsibility |
| --- | --- | --- |
| `vendor/wgpu` | `codex/deko3d-wgpu29` | Deko3D HAL, FFI, resource semantics, capability reporting, and runtime WGSL compilation |
| `vendor/bevy` | `codex/deko3d-horizon` | Horizon platform wiring, Deko3D surface selection, shader capture, and persistent-cache configuration |
| this repository | `codex/warbell-wgpu29` | Warbell Switch profile, game integration, WGSL assets, NRO packaging, and hardware diagnostics |
| `../switch` | `codex/switch-wgpu29-support` | External homebrew harnesses and hardware documentation only |
| `/Users/sharif/Code/wgpu-deko3d-30-reference` | existing fork branch | Reference and documentation only |

Do not create a parallel backend patch series in `../switch`. Backend changes belong in `vendor/wgpu`; harness-only changes belong in `switch`.

## Current milestone

The port has an emulator-tested, visually accepted game vertical slice using the native full-PBR
path. It has not been run on physical hardware.

Implemented:

- Horizon runner using `appletMainLoop`, plugin readiness, AppExit, and teardown.
- Bevy window surface acquisition and presentation through the Deko3D backend.
- A real Bevy plane, cube, directional light, and camera rendered through the wgpu 29 Deko3D path in Ryujinx.
- Runtime WGSL compilation through Naga and the extracted Maxwell NAK backend. Deko3D
  already uses upper-left origin and zero-to-one depth, so generated vertex programs do
  not apply an OpenGL Y/depth fixup.
- The compiler carries mutation-bearing loop exits through per-invocation Maxwell local memory
  and distinguishes switch breaks from enclosing-loop breaks. Compiler revision
  `4df762641` and wgpu revision `3ecd41968` are the current integration baseline; revision
  `ddfcf3013` with wgpu `5eaa63ab6` passed the clean runtime-WGSL Ryujinx probe at
  `target/ryujinx-logs/warbell-20260718T094954Z` in nine seconds with all three visual checks.
- Native sampled 3D textures, including a D2-array staging copy into Deko3D 3D images for padded
  WebGPU buffer uploads. `DkCopyBuf` strides are passed in bytes as required by Deko3D.
- RomFS mounted before `AssetPlugin`, with `assets/` packaged at `romfs:/assets`.
- Representative PNG, TTF, and WGSL loads through Bevy's `AssetServer`.
- Gamepad event injection; controller input visibly changes the proof clear color.
- Structured startup, asset, runtime-compiler/cache, frame 1/60/300, and exit diagnostics.
- Deterministic shader capture remains available as a coverage tool, not a runtime input.
- NRO build metadata, SHA-256 output, and nxlink deployment logging.

The Switch feature now builds the complete Warbell game. Warbell remains the consumer and
regression fixture: backend work must not delete or replace gameplay systems to make the port
easier. The local emulator profile has the user's keys and the pinned D3-fixed Ryujinx build;
never download or substitute keys.

## Current backend envelope

Implemented and covered by host-side backend/compiler tests and Horizon builds:

- `Rgba8Unorm` FIFO surface.
- Sampled `Rgba8Unorm` and `Rgba8UnormSrgb` textures with one mip and one sample.
- `Depth32Float`.
- Basic buffers, copies, uploads with padded rows, and indexed/non-indexed drawing.
- Native sampled 3D textures and padded multi-slice uploads through a D2-array staging image.
- Culling, front-face selection, dynamic viewport, and dynamic scissor.
- Straight and premultiplied alpha blending plus color write masks.
- Common integer, normalized, half-float, and float vertex formats.
- Four static texture/sampler pairs: `(0,1)`, `(2,3)`, `(4,5)`, `(6,7)`.
- Multiple static uniform buffers below binding 16.
- Fail-closed behavior for invalid operations.
- Compute, indirect draws, storage buffers, dynamic offsets and binding arrays, queries,
  texture copies, pipeline caching, multiview, MSAA/resolve, immediate constants, blend constants,
  stencil reference, and the expanded format/layout coverage required by wgpu.

Remaining acceptance work:

- Physical hardware runtime proof.
- Hardware measurements for frame pacing, CPU time, allocations, and buffer traffic.

The 2026-07-18 full-game non-emulator build produced a 121,364,960-byte NRO in 129.07 seconds
after the relevant dependency rebuild. The pre-optimization baseline was 121,344,480 bytes in
140.33 seconds. These timings are directional because both builds reused the same Cargo target;
the 20,480-byte size increase is 0.017% and comes with the compiler/cache fast path.

The current hot-path cleanup avoids parsing WGSL on exact-name cache hits, parses only once on
cache misses, and passes cached DKSH to wgpu without cloning the bytecode. Deko3D mapped writes
now upload only flushed ranges and no longer upload the complete buffer again on unmap. Native
buffer-to-buffer copies no longer mirror data through CPU shadow buffers or risk overwriting
GPU-produced data with a stale shadow copy.

A clean emulator run with an empty shader-override directory reached
`phase=game_ready frame=60 combat=proven` in 11 seconds and passed all three visual frames:

```text
target/ryujinx-logs/warbell-20260718T183521Z/
NRO SHA-256: dbf13ecdd4e8cd783dcd2028ed0c45b15afe41e900ac526c98d67c275f8c7d01
```

A follow-up health run at `target/ryujinx-logs/warbell-20260718T183744Z/` exercised 33
persistent-cache and five memory-cache shader lookups, reached readiness in 13 seconds, and
reported no compiler, device-loss, validation, or panic signature. An intervening visual run had
two valid frames but correctly failed because Ryujinx resized its window between captures; that
is recorded at `target/ryujinx-logs/warbell-20260718T183633Z/` rather than being presented as a
green run.

## Validated emulator game slice

On 2026-07-16, the emulator-specific `game` NRO reached
`phase=game_ready frame=60 combat=proven` in 16 seconds. Three captured frames passed the regional
visual profile, and the log contained no shader-compiler error, Deko3D device loss, validation
error, or panic. The validated build is:

```text
target/switch-nro/game/cargo-target/horizon-newlib-gcc/debug/warbell-switch.nro
SHA-256: c38b72e30d3f3c4f54542d898565347daf50ba5a48d1e03c9346371e169d079d
```

The evidence bundle is under
`target/ryujinx-logs/warbell-20260716T161004Z/` and is intentionally ignored by Git.

Acceptance order:

1. Direct 3D LUT load diagnostic produces a non-black LUT color.
2. Tone mapping with the 3D LUT produces the expected lit courtyard.
3. The embedded untouched full Bevy PBR fragment produces the lit courtyard and knight.
4. Left stick or D-pad moves and turns the knight within the courtyard.
5. Runtime logs contain no shader-compiler or Deko3D device-loss error.

Two smaller wgpu 29 probes isolate the sampled-3D path before the Warbell run:

```text
../switch/target/wgpu-public-compute-texture/cargo-target/horizon-newlib-gcc/debug/deko-wgpu-public-compute-texture-rs.nro
SHA-256: fe998bdae2aedced214dc8614ff5f26ad3f86d3b36ee2eb86cd40406fa3cfee1

../switch/target/wgpu-public-texture3d/cargo-target/horizon-newlib-gcc/debug/deko-wgpu-public-texture3d-rs.nro
SHA-256: a9703744b68ea70b7c5ddab066817177c735cbf3e8a63884762a80c4e6419706
```

The first uploads four padded slices and validates native `sampler3D` results. The second uploads
and reads back padded 4x4x4 and 2x2x2 mip levels. Keep both as focused regressions when the sampled
3D path changes.

The emulator gate now passes. Use physical hardware acceptance to drive the next backend or game
integration change.

## Hardware acceptance

Build and send the current NRO:

```sh
../switch/experiments/switch1-deko3d-wgpu/tools/bootstrap-devkitpro-switch.sh
SWITCH_APP=probe tools/build-switch-nro.sh
SWITCH_VISUAL_RESULT=passed tools/run-switch-hardware-test.sh probe <switch-ip>
```

The visual result must be set to `passed` only while directly observing or recording the
physical Switch output. The runner rejects emulator-mode or stale-wgpu probe metadata and
writes the NRO hash, exact Warbell/wgpu/compiler revisions, nxlink log, and validation result
under `target/switch-nro/hardware-acceptance/`.

Return to hbmenu NetLoader after the probe exits, then run the independent storage-buffer
compute/readback acceptance test. It compiles WGSL at runtime and requires
the exact GPU result `[7, 13, 19, 25]`:

```sh
DEVKITPRO=/tmp/devkitpro-switch1/opt/devkitpro \
  WGPU_DEKO3D_DIR="$PWD/vendor/wgpu" \
  ../switch/experiments/switch1-deko3d-wgpu/tools/build-wgpu-public-runtime-compute.sh
tools/run-switch-hardware-test.sh compute <switch-ip>
```

Do not substitute a previously built compute NRO after wgpu or the compiler revision changes.
The run manifest is the durable evidence record; physical visual confirmation remains distinct
from automated log health.

Acceptance checklist:

1. The application starts without an abort or shader-compiler error.
2. The courtyard, knight, rival, lighting, and combat HUD appear and present continuously.
3. Controller input moves and turns the knight and can trigger the combat exchange.
4. PNG, font, and WGSL asset loads report success; runtime compilation/cache telemetry is present.
5. Frame diagnostics reach at least frame 300 with no compiler or validation errors.
6. Applet exit produces the expected teardown logs.
7. Repeat in handheld and docked modes and record resolution, screenshots, nxlink logs, crashes, and obvious frame-pacing problems.

Do not broaden the backend before this gate passes. If it fails, fix the smallest confirmed layer: Warbell integration, Bevy platform wiring, wgpu HAL, or harness/toolchain.

## Dependency-ordered roadmap

The runtime WGSL compiler is an active completion goal. Its architecture, gates,
current revisions, and acceptance evidence are in
[`deko-shader-compiler-plan.md`](deko-shader-compiler-plan.md). Supported WGSL now
compiles automatically in the wgpu Deko3D backend. Warbell ships no hash table,
runtime DKSH bundle, or prebuilt proof shaders.

### 1. Minimal recognizable Warbell scene

Replace the proof app with the smallest real gameplay slice:

- Warbell camera and player entity.
- Controller-driven movement.
- One static environment mesh.
- One textured material with depth testing.
- Minimal HUD or debug text.

Gate: walk around a recognizable Warbell scene on hardware for several minutes without validation errors, corruption, or shader-compiler errors.

### 2. Close the shader set

For each representative Switch scene:

1. Run it on desktop with deterministic shader capture enabled.
2. Add each captured shader to the compiler coverage corpus.
3. Require either successful runtime compilation or a typed unsupported-feature error.
4. Add a minimized regression fixture for every compiler failure or miscompile.
5. Require zero validation errors before advancing the scene.

Do not restore hash-keyed embedded artifacts as a correctness path. The persistent
cache may be warmed offline, but it must contain the same validated format that the
runtime compiler produces and must remain optional.

### 3. Add rendering in game-value order

1. Opaque meshes and a constrained `StandardMaterial` path.
2. Alpha-blended UI and text.
3. Additional material textures.
4. A simplified lighting profile.
5. Terrain and creature materials.
6. Transparent world objects and particles.
7. Shadow maps.
8. HDR and postprocessing only after measuring the hardware budget.

Likely early backend work is additional binding capacity, selected formats, mipmapped textures, and texture arrays. Storage buffers, dynamic offsets, MSAA, readback, and compute should wait for concrete demand.

### 4. Define the Switch graphics profile

- Fixed internal resolution or controlled resolution scaling.
- Conservative light count, shadow distance, and cascade count.
- Limited anisotropy and texture residency.
- Explicit CPU, GPU, and memory budgets.
- Optional or disabled expensive desktop effects.

Prioritize stable gameplay and frame pacing. Add visual features one at a time with before/after hardware measurements.

### 5. Finish platform services

- Audio backend and audio asset validation.
- Save-data location and atomic writes.
- Suspend/resume behavior.
- Controller connection and reassignment.
- Applet exit during loading and rendering.
- Full RomFS inventory validation.
- Memory-pressure and long-session tests.

### 6. Harden the port

- Automated host checks for the Deko3D feature combination.
- Deterministic shader-manifest verification.
- Reproducible NRO smoke builds.
- Structured hardware test records.
- Failed-allocation and device-loss behavior.
- Repeated scene-transition and soak tests.
- Focused wgpu 29 backports when necessary.
- A separately planned wgpu upgrade only after the dependency stack adopts it.

## Working rules for the next engineer

- Inspect `git status` in every repository before editing. The sibling `switch` checkout may contain unrelated user work; preserve it.
- Keep each change in the repository that owns the affected layer.
- Make one bounded capability or game slice at a time and gate it on focused host tests plus hardware validation when the target boundary changes.
- Build and run in one gated command when testing an executable so a stale binary cannot run after a failed build.
- Verify behavior against the WebGPU/WGSL specifications; CTS expectations alone are not authoritative.
- Do not commit from the wgpu fork when its local instructions prohibit it. Leave a clean, reviewable diff and report the verification performed.

## Definition of playable

The Switch port is playable when a real Warbell gameplay loop boots from RomFS, accepts controller input, renders its required scene and UI with zero shader-compiler errors, saves safely, handles suspend/resume and exit, and maintains an agreed frame-time and memory budget during a hardware soak test.
