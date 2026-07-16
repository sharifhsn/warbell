# Warbell Switch Workspace

Use this repository as the sole Codex project:

```text
/Users/sharif/Code/warbell-switch
```

Its local engine dependencies are intentionally independent repositories:

```text
warbell-switch/                 Warbell fork and Switch integration
warbell-switch/vendor/bevy/     sharifhsn/bevy, Horizon platform work
warbell-switch/vendor/wgpu/     sharifhsn/wgpu, wgpu 29 Deko3D backend
```

`vendor/` is ignored by Warbell Git because each dependency has its own history,
remote, and branch. Run `tools/bootstrap-switch-deps.sh` after cloning Warbell.
The bootstrap script checks out the required feature branches and fails if they
have not been published; it never substitutes a default branch.

The separate `/Users/sharif/Code/wgpu-deko3d-30-reference` checkout is wgpu 30
reference work only. It is not a dependency of Warbell and must not be used for
Switch implementation or build commands.

Ownership is strict: game and packaging changes belong here, Deko3D backend
changes belong in `vendor/wgpu`, and Bevy/Horizon integration changes belong in
`vendor/bevy`.
