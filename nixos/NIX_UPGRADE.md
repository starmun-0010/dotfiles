# Nix / home-manager upgrade — status and next steps

## Why this started
All 4 profiles (`hermes`, `deck`, `muqsit`, `machine`) were stuck on outdated
software because `flake.nix` pinned `nixpkgs` to the `nixos-24.11` branch,
which hit end-of-life on 2025-06-30 (over a year before this work started).
Only a handful of packages (postman, neovim, wezterm, kanata, protonvpn,
dotnet, popcorntime) were pulled from a separate `pkgs-un` (nixpkgs-unstable)
arg — everything else was frozen on the dead branch. The last real
`home-manager switch` on the `hermes` machine was generation 39, 2025-05-22.

Current stable NixOS release (as of 2026-07-28) is 26.05 "Yarara". 24.11,
25.05, and 25.11 are all EOL.

## Decision made
Asked the user: bump to current stable (26.05, requiring a manual re-bump
every ~6 months — the same habit that caused this problem) vs. go fully
unstable everywhere (matches what `home-manager` already followed via
`pkgs-un`, no branch to remember to bump).

**User chose: fully unstable everywhere.**

## Changes made (uncommitted — see `git status`)
- `flake.nix`:
  - `nixpkgs` input → `nixpkgs/nixos-unstable` (was `nixos-24.11`)
  - `home-manager` input → `github:nix-community/home-manager/master` (was
    `release-24.11`)
  - `home-manager.inputs.nixpkgs.follows` → `nixpkgs` (was
    `nixpkgs-unstable`, which is now removed as a separate input)
  - Removed `pkgs-un` entirely (the separate unstable pkgs import + all
    `extraSpecialArgs = { inherit pkgs-un; }` wiring)
- `chezmoi/common.nix`, `hermes.nix`, `deck.nix`, `machine.nix`: dropped the
  `pkgs-un` module arg; packages that used to be `pkgs-un.foo` are now just
  `pkgs.foo` (everything comes from the same, now-unstable, `pkgs`).
- Ran `nix flake update`. Lockfile now points to nixpkgs `26.11pre` snapshot
  (2026-07-26) and home-manager `master` (2026-07-27). `nixgl` also bumped
  (was pinned to 2024-04-19).
- Fixed 3 breaking renames found via dry-build of the `hermes` profile:
  - `fira-code-nerdfont` → `nerd-fonts.fira-code` (common.nix)
  - `protonvpn-cli_2` → `proton-vpn-cli` (common.nix)
  - `programs.git.userName`/`userEmail` → `programs.git.settings.user.{name,email}`
    (common.nix)

## Validated so far
- `home-manager build --flake .#hermes --impure` (run from a scratch dir,
  **not** `switch`) succeeds cleanly — no eval/build errors after the fixes
  above. This only builds a new generation, it does **not** touch the live
  environment.
- **Not yet activated.** `home-manager generations` on the `hermes` machine
  still shows generation 39 (2025-05-22) as current — nothing has actually
  switched.

## Remaining steps (in order)
1. Dry-build the other profiles the same way, from this repo dir:
   - `home-manager build --flake .#deck --impure`
   - `home-manager build --flake .#muqsit --impure`
   - These can only be *build*-validated from wherever you run this repo;
     `deck`/`muqsit` are other physical machines, so full switch-time
     validation has to happen on those machines themselves.
2. For the NixOS `machine` config (system-level, not home-manager-only):
   run `sudo nixos-rebuild build --flake .` on that machine (build-only, no
   switch) and review the diff before switching.
3. Get explicit go-ahead before running any `switch` — these are live
   changes to daily-driver machines (kanata systemd service, i3/wezterm
   configs, etc.) that can't be fully exercised from a sandbox.
4. To activate on `hermes`, from `/src/repos/dotfiles.git/2025/nixos`:
   ```
   home-manager switch -b backup --flake .#hermes --impure
   ```
   Rollback if needed: `home-manager switch --switch-generation 39`.
5. Once everything is switched and confirmed working, commit the changes
   (currently uncommitted — `git status` shows `flake.nix`, `flake.lock`,
   and all 4 `chezmoi/*.nix` files modified).
6. Going forward: since there's no release branch to track anymore, just
   run `nix flake update` periodically (e.g. monthly) to avoid drifting
   this far out of date again.
