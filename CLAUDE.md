# Nix Multi-System Configuration

Multi-system flake repo for darwin (macOS) and NixOS machines.

## Structure

- `darwin/` - macOS systems with per-host overrides in `{hostname}/extra-*.nix`
- `linux/{hostname}/` - NixOS systems (standalone flakes)
- `common/` - shared configs, ssh keys, scripts

## Commands

See `Taskfile.yml` for available commands (`task --list`).

## Patterns

- Host-specific configs override/merge with base configs
- SSH keys in `common/ssh/` enable cross-machine access
- `hardware-configuration.nix` must come from target machine

## Checks

Run `task check` before committing.
