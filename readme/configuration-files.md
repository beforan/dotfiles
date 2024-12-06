`// TODO: Tidy up and provide guidance on actually writing configurations`

# Host Configuration Files

Refer to [nixfiles structure](#nixfiles-structure) to understand the structure of the repository and how this relates to different host configuration.

All hosts must be added to the root flake (`flake.nix`), in the correct section based on the Host Type.

## Nixfiles Structure

In this repo, all Nix related files except the root flake definition (`flake.nix`) are located in `/nixfiles`.

In there is a `shared` folder, for:

- shared system configuration (`configuration.nix`)
- shared Home Manager configuration (`home.nix`)
- optional shared sub-modules (see below) designed for composing modules together in different ways, or otherwise just to keep file lengths down.

Also each host has its own folder, containing:

- a host specific Home Manager configuration (`home.nix`)
- if it's not a standalone Home Manager host, a host specific system configuration (`configuration.nix`).

Here's the above as structured in the repo:

```
/
├─ dotfiles/              # actual config files, set up by Home Manager
├─ nixfiles/              # nix files
│  ├─ example-nixos-host/   # a Linux host, running NixOS
│  │  ├─ configuration.nix    # NixOS system configuration
│  │  ├─ home.nix             # Home Manager configuration
│  ├─ cloud/                # a Linux host, managed by standalone Home Manager
│  │  ├─ home.nix             # Home Manager configuration
│  ├─ Shadow/               # a macOS host, managed by nix-darwin
│  │  ├─ configuration.nix    # nix-darwin system configuration
│  │  ├─ home.nix             # Home Manager configuration
│  ├─ shared/               # shared modules
│  │  ├─ configuration.nix    # system configuration for all hosts
│  │  ├─ home.nix             # Home Manager configuration for all hosts
│  │  ├─ home.dev.nix         # Home Manager Dev submodule
│  │  ├─ home.standalone.nix    # Home Manager submodule for all standalone Home Manager hosts
├─ flake.nix              # root flake definition
```

### Shared Home Manager Submodules

Submodules are effectively nested and you'd typically expect to always include the parent of a child module you're importing, as the children gfet more specific and optional.

For example if you wanted to import a hypothetical `home.dev.python.nix` to add python tooling to your setup, you would import all of the following:

- `home.nix`
- `home.dev.nix`
- `home.dev.python.nix`
- any other branches of submodule you want, such as `home.standalone.nix`

This is because `home.dev.python.nix` will only add the python specific packages and programs; it is assumed you (and other dev environments) will want the common dev tooling from `home.dev.nix` as well.

Lifting common things into parent modules helps keep things DRY.

Having Hosts explicitly import all modules they want rather than chaining imports helps keep things flexible and composable.

## Configuration by Host Type

Below is a breakdown of configuration file structure based on the different possible Host Types:

- NixOS
  - NixOS hosts will:
    - be added to the root flake under `nixOsConfigurations`
    - have a `configuration.nix`
      - imports `shared/configuration.nix` and possibly other modules
      - sets host specific NixOS config.
        - recommendations:
          - Have your `configuration.nix` import any relevant shared configuration files, e.g. `shared/configuration.nix` at a minimum.
          - Enable [Flatpaks](sources/flatpak.md): `services.flatpak.enable = true;`
          - Allow Unfree packages at a system level: `nixpkgs.config.allowUnfree = true;`
          - Consider adding other [Core system packages](sources/host-nix.md) to your configuration.
    - use Home Manager as a NixOS module
    - have a `home.nix`
      - imports:
        - `shared/home.nix`
        - optionally other Home Manager sub-modules
      - sets host specific Home Manager config
- macOS (`nix-darwin`) - e.g. `Shadow`
  - macOS hosts will:
    - be added to the root flake under `darwinConfigurations`
    - have a `configuration.nix`
      - imports `shared/configuration.nix` and possibly other modules
      - sets host specific NixOS config.
    - use Home Manager as a nix-darwin module
    - have a `home.nix`
      - imports:
        - `shared/home.nix`
        - optionally other Home Manager sub-modules
      - sets host specific Home Manager config
- Other Linux (Standalone Home Manager) - e.g. `cloud`
  - Other Linux hosts will:
    - be added to the root flake under `homeConfigurations`
    - use Home Manager in Standalone mode
    - have a `home.nix`
      - imports:
        - `shared/home.nix`
        - `shared/home.standalone.nix`
        - optionally other Home Manager sub-modules
      - sets host specific Home Manager config
    - _NOT_ have a `configuration.nix`
