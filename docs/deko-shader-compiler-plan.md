# Deko Shader Compiler: End-to-End Execution Plan

Status: active goal, runtime integration implemented; hardware closure in progress

## Goal

Make supported WGSL behave like a normal wgpu shader source on Nintendo Switch:

```text
WGSL
  -> Naga parse, validation, and pipeline specialization
  -> Naga IR to NAK IR lowering
  -> extracted Mesa NAK Maxwell backend
  -> GM20B machine code and shader program header
  -> DKSH container and Deko3D binding metadata
  -> wgpu-hal Deko3D shader module
```

The finished path must compile shaders at runtime without Warbell-specific hashes,
embedded shader variants, UAM, Mesa, a host-side compiler, or a proprietary Nintendo
SDK. Offline precompilation may remain as an optional cache warmer, never as a
correctness requirement.

## Current verified status (2026-07-18)

- `deko-shader-compiler` is a standalone, publishable Rust workspace at revision
  `d642b3feb3e4164aa6f865bdae5db6ca76cf613d`. It lowers supported Naga/WGSL directly
  through the extracted Maxwell NAK backend and emits validated DKSH without Mesa,
  UAM, or proprietary SDK libraries at runtime.
- wgpu revision `77024ecab` makes that compiler the
  default Deko3D WGSL path. An installed artifact provider remains a higher-priority
  diagnostic override, but ordinary applications no longer need one.
- The compiler workspace has 62 passing compiler tests and 120 tests across all workspace
  suites, strict clippy, rustdoc, package-content checks, provenance enforcement, and three
  buildable fuzz targets. The wgpu Deko3D HAL has 32 passing host tests, and the
  no-provider acceptance NRO links for Horizon without
  `getrandom` or any host compiler dependency.
- wgpu revision `e16bd0643` correctly marks the Deko CPU shadow mapping as
  non-coherent and downloads GPU-written ranges for `MAP_READ`. A Ryujinx acceptance
  probe proves CPU upload, Deko buffer copy, fence flush, invalidation, and exact
  readback end to end.
- The no-provider compute probe reaches a valid compute shader, binds storage targets
  0 and 1 with the correct input contents, and dispatches four workgroups. Ryujinx
  currently leaves the output unchanged. The identical failure with an official
  UAM-produced DKSH rules out the new compiler as the differentiator; physical Switch
  execution remains the authoritative P0/P2 gate.
- Warbell no longer installs an artifact provider or ships its hash-keyed runtime DKSH
  bundle. Bevy configures `sdmc:/switch/warbell/cache/wgpu-deko3d`; a clean Ryujinx run
  compiled and persisted 29 distinct shaders, then a warm run loaded all 29 from SD.
  Both reached the probe-ready gate with no overrides. Cold resolution recorded 34
  requests in 150,094 microseconds total (29 compiled, five RAM hits); warm resolution
  recorded 34 in 39,348 microseconds (29 persistent hits, five RAM hits).
- Native Maxwell TXD lowering compiles `textureSampleGrad` for 1D/2D textures,
  including array layers and offsets. 3D and cube gradients use Mesa's established
  derivative-to-LOD rewrite, including cube face selection and quotient-rule derivatives.
  The compiler and wgpu integration suites cover 3D, cube, and cube-array forms.
- Subgroup barriers lower to CTA-scoped memory fences on GM20B. Maxwell's lockstep warp
  execution supplies the subgroup rendezvous without a whole-workgroup `BAR.SYNC`, which
  would be too strong and could deadlock unrelated warps.
- `subgroupBroadcastFirst` lowers through an active-lane vote and indexed shuffle.
  Compute WGSL also receives native `subgroup_invocation_id`, constant GM20B
  `subgroup_size`, and workgroup-geometry-derived `subgroup_id` and `num_subgroups`.
  Boolean `subgroupAll`/`subgroupAny` reductions and `subgroupBallot` lower directly
  to Maxwell votes, including active-lane ballots for partially occupied warps.
  Arithmetic and bitwise reductions plus add/multiply inclusive and exclusive scans
  support scalar and vector operands with explicit sparse-active-lane handling.
- `workgroupUniformLoad` emits the required barrier-load-barrier sequence for scalar,
  atomic, and aggregate values. Divergent `if` arms predicate stores, atomics, image writes,
  and discard so those effects do not leak into invocations on the other arm; pure SSA and
  structured-control instructions remain unconditional for NAK scheduling correctness.
  Nested and sequential value or void returns remove completed invocations from later effects,
  with return choices merged only at the function boundary. Returns taken inside loops also
  remove completed invocations from side effects after the loop. Terminal unconditional loop
  `break` and `continue` preserve written locals at exit and route through continuing blocks;
  control-only nested lexical controls are recognized, changed live values on direct terminal
  breaks receive selective exit phis, and unreachable CFG-node removal remaps every predecessor
  and successor index. Mutation-bearing nested exits and side-effecting conditional-break
  prefixes are rejected until post-loop liveness can be modeled without destabilizing existing
  Bevy shaders.
  Divergent helper functions merge `ptr<function, T>` writes per invocation and propagate
  pointer updates back from both void and value-returning calls.
  Atomic WGSL operations on `r32uint` and `r32sint` storage textures lower to native Maxwell
  `SUATOM`; wgpu advertises `TEXTURE_ATOMIC` and restricts atomic usage to those two formats.
  WGSL switch cases with multiple selectors lower as one disjunctive case predicate while
  preserving default-case ordering. Ordinary switches retain the proven direct lowering path;
  unsupported non-empty source-IR fall-through remains a structured compilation error.
  Array `textureNumLayers` queries are native, including exact cube-array face-to-layer
  conversion, and pipeline-specialized compute workgroup-size overrides reach DKSH metadata.
- Multiview pipelines load `view_index` from wgpu's reserved Deko uniform slot, emit the
  Maxwell layer output for each replayed vertex draw, and expose that layer to fragment WGSL.
- The compiler backend ABI has advanced through 45 so persistent cache entries cannot cross
  gradient, subgroup, texture-query, or specialization codegen boundaries. The latest clean,
  provider-free Ryujinx probe at `target/ryujinx-logs/warbell-20260718T084855Z`
  reached ready in nine seconds, passed all three visual captures, and passed the run-health
  gate with diagnostic overrides disabled.
- Full-game corpus closure, explicit physical-hardware timing/memory budgets,
  and physical vertex/fragment/compute execution remain incomplete, so this goal is
  not complete.

## Completion contract

The goal is complete only when all of the following are true:

- `Device::create_shader_module` accepts supported WGSL on Horizon without installing
  a game-specific artifact provider.
- Vertex, fragment, and compute entry points compile and execute correctly on a
  physical Switch.
- Bevy can create all pipeline variants needed by Warbell with zero provider misses.
- Supported WGSL includes the target's required control flow, numeric operations,
  buffers, textures, samplers, atomics, barriers, built-ins, override constants, and
  binding layouts.
- Compilation returns structured errors for invalid or unsupported input. Compiler
  input must not panic, abort, corrupt memory, or hang the GPU.
- Output is deterministic for a fixed compiler version and compilation key.
- A bounded RAM cache and persistent SD cache remove repeat compilation work.
- Warm-cache startup and memory use meet an explicit Switch budget; cold compilation
  has per-shader timing telemetry and no unbounded frame stalls.
- Unit, snapshot, differential, fuzz, emulator, and physical-hardware suites pass.
- The public crate has complete package metadata, API documentation, licensing,
  provenance, changelog, examples, and a successful package dry run.
- The compiler, wgpu, Bevy integration, and Warbell changes are committed and pushed
  to their owning repositories.

## Locked repository ownership

`warbell-switch` remains the product root. Its ignored `vendor/` directory contains
independent engine repositories.

Create a new independent repository at:

```text
warbell-switch/vendor/deko-shader-compiler/
```

with its own eventual `sharifhsn/deko-shader-compiler` remote. It is not committed as
copied source in the Warbell repository. Warbell's bootstrap and workspace docs will
pin the repository and revision, as they already do for Bevy and wgpu.

Initial compiler workspace:

```text
deko-shader-compiler/
  crates/deko-shader-compiler/         public safe API and Naga lowering
  crates/deko-shader-compiler-macros/  extracted/adapted NAK proc macros
  crates/deko-nak/                     private machine backend crate
  crates/deko-dksh/                    DKSH and Deko ABI model/serializer
  tests/                               corpus, differential, and golden fixtures
  fuzz/                                parser/lowering/backend fuzz targets
  xtask/                               provenance, fixture, disassembly, and package jobs
```

Keep the public API independent of wgpu types. `wgpu-hal` adapts its validated Naga
module and pipeline information into the compiler request. This keeps the compiler
usable by Deko3D applications outside wgpu and prevents its release cycle from being
coupled to Warbell.

## Non-negotiable design rules

1. Reuse NAK; do not create a clean-room Maxwell optimizer, allocator, scheduler, or
   encoder unless a specific NAK component proves unusable.
2. Use Naga IR directly in the finished runtime. Mesa/NIR may be used only by host
   research and differential oracles.
3. Preserve every imported SPDX header and maintain a machine-checkable provenance
   manifest containing upstream commit, original path, local path, and modification
   status.
4. Replace backend panics reachable from shader input with typed compiler errors.
5. Keep target policy explicit: Switch 1 GM20B first. Do not silently generalize to
   other NVIDIA architectures.
6. Treat DKSH bytes and GPU execution as untrusted-output boundaries. Validate sizes,
   offsets, register counts, headers, and resource maps before passing them to Deko3D.
7. Every claimed operation needs a semantic test and, when it affects native code or
   ABI, a physical-hardware test.
8. UAM output is an oracle, not a byte-for-byte specification and not a runtime
   dependency.

## Work breakdown and gates

### Phase 0: baseline and feasibility

Deliverables:

- Record the exact Mesa/NAK upstream commit and all imported licenses.
- Freeze a compiler request/response model: module, entry point, stage, pipeline
  constants, binding map, target capabilities, diagnostics, binary, and reflection.
- Describe the Deko binding ABI already implemented by wgpu and the existing
  `wgsl-to-dksh` reflection schema.
- Build a host-side NAK SM50 experiment that emits one vertex, one fragment, and one
  compute program.
- Package those programs as DKSH and compare structural metadata with UAM fixtures.
- Run a triangle and a storage-buffer compute dispatch on physical Switch hardware.

Gate P0: all three stages load and execute on hardware, or an evidence-backed ABI gap
is identified with a bounded correction plan. No large-scale frontend work starts
before this gate.

### Phase 1: standalone NAK backend

Deliverables:

- Import the minimal NAK Rust module graph, SM50 encoder, shader program header logic,
  and required Mesa Rust compiler utilities.
- Replace `nak_bindings`, `nv_device_info`, Mesa CFG/dataflow helpers, generated C
  bindings, and NIR-facing APIs with safe local target structures.
- Exclude NIR conversion, QMD launch support, unrelated SM20/SM32/SM70 encoders, DRM,
  Nouveau winsys, and Mesa C build machinery from the runtime dependency graph.
- Add deterministic instruction encoding, liveness, allocation, spilling, scheduling,
  and header snapshot tests.
- Audit all `panic!`, `unwrap`, unchecked indexing, integer conversion, and unsafe code.

Gate P1: `deko-nak` builds and tests on host and Horizon with no Mesa/C/C++ linkage and
can encode synthetic GM20B shaders deterministically.

### Phase 2: minimal Naga frontend

Deliverables:

- Lower scalar/vector values, constants, loads/stores, arithmetic, conversions,
  comparisons, selection, functions, branches, loops, and returns.
- Lower vertex attributes, position, varyings, fragment outputs, invocation built-ins,
  and compute workgroup built-ins.
- Implement uniform buffers, storage buffers, private/function/workgroup memory, basic
  sampled textures, samplers, and storage textures.
- Specialize the selected entry point and pipeline override constants before native
  lowering.
- Preserve source spans through diagnostics where Naga provides them.

Gate P2: curated WGSL triangle, textured render, storage-buffer compute, and
workgroup-memory compute fixtures match expected readback on hardware.

### Phase 3: complete the Switch-supported WGSL surface

Track coverage as a matrix rather than a single percentage:

- value types and numeric operations
- composite construction, access, pointers, and address spaces
- structured and divergent control flow
- derivatives, interpolation, sampling, gather, comparison, and queries
- texture dimensions, arrays, cube maps, mip levels, and storage formats
- atomics, workgroup memory, barriers, and compute workgroup sizes
- binding arrays, dynamic offsets, push/immediate constants, and robustness
- vertex/instance built-ins, fragment tests, sample state, and multiview

Each row is classified as supported, rejected with a typed reason, blocked by the wgpu
Deko backend, or unsupported by GM20B. Compiler support is not used to over-advertise a
wgpu feature until the HAL implementation and hardware tests also pass.

Gate P3: every operation reachable through the advertised wgpu Deko3D capabilities is
either passing semantic/hardware tests or rejected during validation before codegen.

### Phase 4: Deko ABI and DKSH production

Deliverables:

- Encode stage-correct Maxwell shader program headers for GM20B.
- Map Naga resource bindings onto Deko constant buffers, storage buffers,
  texture/sampler handles, images, and immediate constants.
- Serialize aligned DKSH control/code sections and append versioned binding metadata.
- Validate the complete container using both compiler-side and wgpu-hal parsers.
- Differentially test behavior against the existing UAM artifact corpus, including the
  Switch lab's compute, storage, dynamic-binding, mip, MSAA, and texture matrices.

Gate P4: DKSH output for representative vertex, fragment, and compute fixtures passes
container validation, disassembly checks, readback tests, and repeated hardware runs.

### Phase 5: wgpu runtime integration

Deliverables:

- Add the compiler as an optional Deko3D dependency of `wgpu-hal`.
- Compile from wgpu's already validated Naga module plus selected entry point and
  pipeline constants, avoiding a second parse when the internal API permits it.
- Make the existing artifact provider an optional diagnostic/fallback feature during
  migration, then remove it from Warbell's normal path.
- Map compiler diagnostics into normal wgpu validation/device errors.
- Add compiler versioning, telemetry, cancellation boundaries, and memory limits.
- Implement a deterministic cache key over canonical module content, entry point,
  stage, override values, binding layout/ABI, target, feature flags, robustness policy,
  and compiler version.
- Use a bounded in-memory cache and atomic persistent writes on SD. A corrupt or stale
  cache entry must be rejected and regenerated.

Gate P5: an unmodified wgpu application can create WGSL shader modules and render or
dispatch on Switch without a provider or prebuilt artifact.

### Phase 6: Bevy and Warbell closure

Deliverables:

- Run Bevy's deterministic final-WGSL capture as a coverage corpus, not a source of
  required precompiled artifacts.
- Compile all startup, gameplay, UI, PBR, terrain, creature, shadow, HDR,
  postprocessing, and internal wgpu compute shaders used by Warbell.
- Delete Warbell's hash table and embedded runtime DKSH once the compiler path has a
  rollback-tested replacement.
- Validate cold cache, warm cache, corrupted cache, low-memory, and compiler-error
  behavior.
- Complete emulator regression, handheld and docked physical tests, controller play,
  scene transitions, suspend/resume, teardown, and a long soak.

Gate P6: full Warbell gameplay reaches the existing definition of playable with zero
shader-provider dependencies, validation failures, GPU hangs, or shader miscompiles.

### Phase 7: hardening and release

Deliverables:

- Differential corpus against UAM and Mesa NAK where semantics overlap.
- Property tests for IR invariants, register allocation, DKSH layout, and cache keys.
- Fuzz WGSL-to-Naga boundaries, Naga-to-NAK lowering, backend passes, and DKSH parser.
- Maintain a minimized regression fixture for every compiler or GPU-hang defect.
- Run formatting, lints, docs, tests, Horizon build, package listing, and package dry
  run from a clean checkout.
- Publish support tables, architecture notes, upstream update procedure, security
  policy, changelog, and third-party notices.

Gate P7: all completion-contract items pass and all owning repositories are clean,
committed, and pushed.

## Test pyramid

1. Pure host tests: parsing request models, Naga lowering, IR validation, backend
   invariants, encoding, headers, DKSH layout, cache behavior, and diagnostics.
2. Golden tests: deterministic disassembly, metadata, and selected complete DKSH
   fixtures. Avoid broad fragile byte snapshots when semantic assertions are stronger.
3. Differential tests: execute or inspect equivalent shaders through UAM, Mesa NAK,
   and the new compiler; compare observable results rather than requiring identical
   instruction streams.
4. Emulator tests: fast lifecycle, validation, artifact, and visual regressions.
5. Physical tests: readback-driven semantics, GPU safety, timing, memory, handheld,
   docked, suspend/resume, teardown, and soak.
6. Application tests: wgpu examples, Bevy render tests that can run on the target, and
   the complete Warbell shader/gameplay corpus.

## Principal risks

| Risk | Early mitigation |
| --- | --- |
| NAK's NVK resource ABI differs from Deko3D | P0 native execution before frontend investment |
| NAK assumes NIR lowering guarantees | Inventory every `from_nir` precondition and assign it to Naga or the new lowering layer |
| Exact GM20B scheduling/device values differ | Derive a target descriptor from authoritative headers and verify with stress fixtures on hardware |
| Backend panic or miscompile hangs the GPU | Typed errors, IR verifier after every debug pass, minimized hardware corpus, watchdog-aware runs |
| Runtime compilation stalls Bevy | Per-stage timing, background/prewarm API where wgpu permits, bounded cache, warm-start acceptance budget |
| Naga or NAK upstream drift | Versioned internal IR boundary, provenance manifest, scripted upstream diff report |
| Scope expands to unsupported WebGPU features | Capability matrix ties compiler claims to wgpu HAL and GM20B hardware evidence |
| Physical hardware is unavailable | Continue host/emulator work, but never close a hardware gate from emulator evidence |

## Planning estimates

The expected source footprint is 65-105k lines including imported backend and tests,
with roughly 20-35k lines of project-specific production code. For one experienced
compiler/graphics engineer, the order-of-magnitude schedule is:

- P0 feasibility: 2-6 weeks
- P1 standalone backend: 1-2 months
- P2 useful vertical slice: 1-2 months
- P3-P5 broad wgpu support and integration: 3-6 months
- P6-P7 Warbell closure and hardening: 3-9 additional months

These are planning ranges. Gate evidence, not elapsed time or source volume, determines
progress.

## Execution discipline

- Keep one active gate at a time and land small, bisectable commits in the owning repo.
- Use cheap read-only agents for inventories, fixture classification, upstream mapping,
  test enumeration, and repetitive audits. Reserve the primary agent for architecture,
  unsafe/compiler implementation, integration, and final verification.
- Never let two agents edit the same crate or interface concurrently.
- Run host checks continuously; run emulator checks when a target-facing slice lands;
  run hardware checks whenever machine code, shader headers, resource ABI, or advertised
  features change.
- Preserve existing Warbell and sibling Switch-lab worktrees. Inspect status before
  every edit and stage only files owned by the current change.
