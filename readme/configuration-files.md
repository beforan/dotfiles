`// TODO: Tidy up and provide guidance on actually writing configurations`

# Host Configuration Files

Refer to [nixfiles structure](#nixfiles-structure) to understand the structure of the repository and how this relates to different host configuration.

All hosts must be added to the root flake (`flake.nix`), in the correct section based on the Host Type.

## Nixfiles Structure

In this repo, all Nix related files except the root flake definition (`flake.nix`) are located in `/nixfiles`.

In there is a `shared` folder, for:

- shared system configuration (`configuration.nix`)
- shared Home Manager configuration (`home.nix`)
  - with system-specific variants e.g. `darwin.nix`, `linux.standalone.nix`
- optional shared sub-modules (see below) designed for composing modules together in different ways, or otherwise just to keep file lengths down.
  - with system-specific variants e.g. `linux.nix`, `darwin.aarch64.nix`

Also each host has its own folder, containing:

- a host specific Home Manager configuration (`home.nix`)
- if it's not a standalone Home Manager host, a host specific system configuration (`configuration.nix`).

Here's the above as structured in the repo:

```
/
├─ dotfiles/                  # actual config files, set up by Home Manager
├─ nixfiles/                  # nix files
│  ├─ example-nixos-host/       # a Linux host, running NixOS
│  │  ├─ configuration.nix        # NixOS system configuration
│  │  ├─ home.nix                 # Home Manager configuration
│  ├─ cloud/                    # a Linux host, managed by standalone Home Manager
│  │  ├─ home.nix                 # Home Manager configuration
│  ├─ Shadow/                   # a macOS host, managed by nix-darwin
│  │  ├─ configuration.nix        # nix-darwin system configuration
│  │  ├─ home.nix                 # Home Manager configuration
│  ├─ shared/                   # shared modules
│  │  ├─ home/                    # Home Manager modules
|  |  |  |- dev/                    # Dev submodules
|  |  |  |  |- k8s/                   # Kubernetes Dev submodules
|  |  |  |  |  |- home.nix              # BASE Kubernetes Dev submodule (for all hosts)
|  |  |  |  |- home.nix               # BASE Dev submodule (for all hosts)
|  |  |  |  |- linux.nix              # Dev submodule for all Linux hosts
|  |  |  |- work/                    # Work submodules
|  |  |  |  |- home.nix               # BASE Work submodule (for all hosts)
|  |  |  |- darwin.nix                # Home Manager submodule for all macOS hosts
|  |  |  |- home.nix                # BASE Home Manager module (for all hosts)
|  |  |  |- linux.standalone.nix    # Home Manager submodule for all Linux Standalone (not NixOS) hosts
│  │  ├─ configuration.nix        # Nix configuration for all hosts
├─ flake.nix                  # root flake definition
```

### Shared Home Manager Modules

#### System Variants

The Shared Home Manager Modules are all presented as a "BASE" module, containing configuration for ALL hosts, and then increasingly specific system variants where required.

The system-specific variants always import their less-specific siblings, and so hosts should always import the most specific applicable module.

e.g. where the available files are:

- `home.nix`
- `darwin.nix`
- `darwin.aarch64.nix`
- `linux.standalone.nix`

Then the below hosts would import files as follows:

- Apple Silicon macOS - `darwin.aarch64.nix` (imports `darwin.nix` and `home.nix`)
- Intel macOS - `darwin.nix` (imports `home.nix`)
- Any Arch Fedora Linux - `linux.standalone.nix` (imports `home.nix`)
- Any Arch NixOS - `home.nix`

#### Optional Submodules

Submodules are nested, but independent.

Each deeper nested level is an optional extension of its parents, so you'd typically expect to always include the parent of a child module you're importing, as the children get more specific and optional.

For example if you wanted to add Kubernetes development tools to your setup, you'd import all the following from `/shared/home/`:

- `home.nix`*
- `dev/home.nix`
- `dev/k8s/home.nix`
- any other branches of submodules you want, such as `work/home.nix`

* bear in mind that `home.nix` is always the BASE module; you may actually import a more specific variant e.g. `darwin.nix`

This is because `dev/k8s/home.nix` will only add the Kubernetes specific packages and programs; it is assumed you (and other dev environments) will want the common dev tooling from `dev/home.nix` as well.

Lifting common things into parent modules helps keep things DRY.

Having Hosts explicitly import all modules they want rather than chaining imports helps keep things flexible and composable, and makes Host configuration imports clearer.

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
        - `shared/home/home.nix`
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
        - `shared/home/darwin.nix`
        - optionally other Home Manager sub-modules
      - sets host specific Home Manager config
- Other Linux (Standalone Home Manager) - e.g. `cloud`
  - Other Linux hosts will:
    - be added to the root flake under `homeConfigurations`
    - use Home Manager in Standalone mode
    - have a `home.nix`
      - imports:
        - `shared/home/linux.standalone.nix`
        - optionally other Home Manager sub-modules
      - sets host specific Home Manager config
    - _NOT_ have a `configuration.nix`
