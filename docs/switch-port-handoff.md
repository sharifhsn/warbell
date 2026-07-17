# Warbell Switch Port Handoff

Last updated: 2026-07-16

## Goal

Run the Bevy 0.19 Warbell game on Nintendo Switch through an experimental Deko3D backend while keeping the active implementation on wgpu 29. The wgpu 30 fork is reference material only; do not transplant it or make the Switch port depend on it. Revisit an upgrade only when Bevy and the surrounding dependency stack move forward.

## Repository ownership

| Repository | Branch | Responsibility |
| --- | --- | --- |
| `vendor/wgpu` | `codex/deko3d-wgpu29` | Deko3D HAL, FFI, resource semantics, capability reporting, and DKSH artifact lookup |
| `vendor/bevy` | `codex/deko3d-horizon` | Horizon platform wiring, Deko3D surface selection, shader capture, and artifact-provider installation |
| this repository | `codex/warbell-wgpu29` | Warbell Switch profile, game integration, assets, shader artifacts, NRO packaging, and hardware diagnostics |
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
- Metadata-aware native-coordinate DKSH artifacts. Deko3D already uses upper-left origin and zero-to-one depth, so vertex artifacts must not apply the OpenGL Y/depth fixup.
- Native DKSH artifacts for Bevy tone mapping and the untouched full Bevy PBR fragment are now
  embedded and selected by their captured WGSL hashes. The earlier constrained material shader
  remains in the tree as a diagnostic reference, not the active PBR artifact.
- Native sampled 3D textures, including a D2-array staging copy into Deko3D 3D images for padded
  WebGPU buffer uploads. `DkCopyBuf` strides are passed in bytes as required by Deko3D.
- RomFS mounted before `AssetPlugin`, with `assets/` packaged at `romfs:/assets`.
- Representative PNG, TTF, and WGSL loads through Bevy's `AssetServer`.
- Gamepad event injection; controller input visibly changes the proof clear color.
- Structured startup, asset, shader-provider, frame 1/60/300, and exit diagnostics.
- Deterministic shader capture and exact `(final WGSL SHA, stage, entry point)` DKSH lookup.
- NRO build metadata, SHA-256 output, and nxlink deployment logging.

The Switch feature now runs a small controller-driven Warbell courtyard with a primitive knight,
castle walls, towers, lighting, HUD, and a deterministic combat exchange, not the full gameplay
modules. The local emulator profile has the user's keys and the pinned D3-fixed Ryujinx build;
never download or substitute keys.

### Known-good commits

wgpu 29:

- `6c7d03302` Add experimental Deko3D backend for wgpu 29
- `06041c2f6` Support opaque textured Deko3D rendering
- `331d2128f` Add Deko3D WGSL artifact provider
- `1bc4c871a` Support alpha blended Deko3D UI rendering
- `b6fb8cafe` Support multiple static Deko3D bindings

Bevy:

- `cddb2f362` Add Horizon Deko3D renderer support
- `f4f0179d7` Add deterministic shader capture infrastructure
- `a4bd4640e` Add Deko3D shader capture planning tool
- `1729ae1a0` Install Deko3D shader artifact providers

Warbell:

- `b102e87` Add Switch Horizon runner and NRO build
- `e932b3a` Add shader capture desktop feature
- `e8f62de` Embed Deko3D proof shaders
- `b707658` Add Switch hardware diagnostics
- `bc5c760` Render Deko3D shader proof on Switch
- `f65de12` Prove Switch assets and controller render state

Harness:

- `8146483` Update Deko3D triangle harness for wgpu 29

## Current backend envelope

Supported enough for the proof and the first simple scene:

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
- Fail-closed behavior for unsupported operations.

Known missing or intentionally deferred:

- Physical hardware runtime proof.
- Full Warbell gameplay and its shader closure.
- Storage buffers and dynamic offsets.
- Broader texture-array, mipmap, and MSAA coverage beyond the current workload.
- Broader format coverage beyond the formats exercised by the captured Warbell shaders.
- Cascaded shadows and depth texture arrays.
- HDR and postprocessing, including bloom, SSAO, depth of field, outlines, god rays, SMAA, and motion blur.
- Nonstandard blend operations, readback, and broader compute workloads.
- Multithreaded or deeply pipelined rendering.
- Switch audio, saves, and suspend/resume integration.

Treat this as a workload-driven list, not a mandate to implement everything. Add a capability only when a captured Warbell scene or hardware failure demonstrates the need.

## Validated emulator game slice

On 2026-07-16, the emulator-specific `game` NRO reached
`phase=game_ready frame=60 combat=proven` in 16 seconds. Three captured frames passed the regional
visual profile, and the log contained no shader-provider miss, Deko3D device loss, validation
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
5. Runtime logs contain no shader-provider miss or Deko3D device-loss error.

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
tools/build-switch-nro.sh
tools/run-switch-nro.sh game <switch-ip>
```

Acceptance checklist:

1. The application starts without an abort or provider miss.
2. The courtyard, knight, rival, lighting, and combat HUD appear and present continuously.
3. Controller input moves and turns the knight and can trigger the combat exchange.
4. PNG, font, WGSL, and embedded DKSH asset loads report success.
5. Frame diagnostics reach at least frame 300 with no provider misses or validation errors.
6. Applet exit produces the expected teardown logs.
7. Repeat in handheld and docked modes and record resolution, screenshots, nxlink logs, crashes, and obvious frame-pacing problems.

Do not broaden the backend before this gate passes. If it fails, fix the smallest confirmed layer: Warbell integration, Bevy platform wiring, wgpu HAL, or harness/toolchain.

## Dependency-ordered roadmap

The runtime WGSL compiler is now tracked as an explicit completion goal. Its locked
architecture, gates, and acceptance contract are in
[`deko-shader-compiler-plan.md`](deko-shader-compiler-plan.md). The artifact-provider
roadmap below remains the validated fallback and migration baseline until the compiler
passes its physical-hardware gates.

### 1. Minimal recognizable Warbell scene

Replace the proof app with the smallest real gameplay slice:

- Warbell camera and player entity.
- Controller-driven movement.
- One static environment mesh.
- One textured material with depth testing.
- Minimal HUD or debug text.

Gate: walk around a recognizable Warbell scene on hardware for several minutes without validation errors, corruption, or provider misses.

### 2. Close the shader set

For each representative Switch scene:

1. Run it on desktop with deterministic shader capture enabled.
2. Generate the exact shader manifest.
3. Compile each `(WGSL hash, stage, entry point)` to DKSH.
4. Embed the artifacts in the Switch build.
5. Make missing artifacts a clear build report and fail-closed runtime error.
6. Require zero provider misses before advancing the scene.

Keep the provider architecture stable. Expand its artifact content rather than adding a second shader path.

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

The Switch port is playable when a real Warbell gameplay loop boots from RomFS, accepts controller input, renders its required scene and UI with zero shader-provider misses, saves safely, handles suspend/resume and exit, and maintains an agreed frame-time and memory budget during a hardware soak test.
