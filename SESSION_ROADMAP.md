# Session roadmap

## Completed in this session

1. Added the requested nixpkgs tooling packages to the existing package lists in `nixos.nix`, `home.nix`, and `shell.nix` with minimal structural change.
2. Preserved the existing browser entries, including `firefox` and `brave`.
3. Vendored the minimal upstream `fl2000_drm` source tree into `pkgs/fl2000_drm/` so the module package is self-contained in the repo.
4. Created a local kernel-module derivation in `pkgs/fl2000_drm/default.nix` that builds the `fl2000` and `it66121` modules against a supplied kernel.
5. Wired that package only into `specialisation."linux-6_1-compat"` via `boot.extraModulePackages` and `boot.kernelModules`.
6. Extended the existing Home Manager activation hook to best-effort install `openclaude` and `oh-my-opencode` non-interactively via npm when they are missing.
7. Updated `README.md` minimally to document the local FL2000 packaging and the added tooling.
8. Fixed a Linux 6.1 compatibility issue in the vendored driver headers by removing the stale `drm_fbdev_generic.h` include and verified the modules build against installed 6.1 headers.
9. Hardened the local FL2000 package with `dontStrip = true` and made npm-based Home Manager activation installs use a writable prefix plus best-effort fallback behavior.

## Validation plan executed

1. Attempted language-server diagnostics on the modified Nix files, but `nixd` is not installed in this environment.
2. Attempted flake evaluation, but the `nix` CLI is not available in this environment.
3. Built the vendored `fl2000_drm` sources successfully with `make KVER=6.1.170-1-MANJARO KSRC=/lib/modules/6.1.170-1-MANJARO/build` and cleaned the generated artifacts afterward.
