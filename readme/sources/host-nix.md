# Stuff I prefer to install via Nix Configuration

This is Host dependent:

- Standalone Home Manager
  - Cannot install these things in this way; use an alternative:
    - Flatpak
    - Brew
    - Native
    - (Preinstalled)
- macOS
  - Some may be installable via `nix-darwin` configuration
  - Note that currently there is no `nix-darwin` shared `configuration.nix` so this is repeated per host
    - `TODO: make shared module`
- NixOS
  - Install via `configuration.nix`
  - Note that currently there is no NixOS shared `configuration.nix` so this is repeated per host
    - `TODO: make shared module`

## NixOS + macOS (`nix-darwin`)

## NixOS only

## macOS (`nix-darwin`) only
