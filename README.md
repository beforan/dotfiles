# dotfiles

These are my dotfiles.

Rather than scripts to put things in place and symlink, my prevailing approach now is to use Nix to do as much as possible declaratively.

For now the focus is standalone Nix Home Manager on linux, and nix-darwin (with Home Manager) on macOS.

In time perhaps NixOS eventually.

More docs to follow as stuff takes shape.

## Nix

- Have Nix; everything else here relies on it.
- Enable flakes.
- Distros like Bazzite will preconfigure all this
- Typically if installing Nix yourself, use https://github.com/DeterminateSystems/nix-installer which also enables Flakes by default.

### Home Manager

We do as much as possible (that's not system configuration) in Home Manager, as that's the most portable netween different setups.

Nix Home Manager:

- takes care of installing user packages/apps as specified in `home.nix`.
- takes care of dotfile configuration by:
  - configuring programs and services directly
  - applying configuration from files in this repo (in `/dotfiles`)
  - symlinking configuration from files in this repo (just like the old scripts did, but from one central standardised location) (in `/dotfiles`)

## Setting up a host

Setting up a hot depends on the host's operating system.

In this repo, all Nix related files except the root flake definition (`flake.nix`) are located in `/nixfiles`.

In there is a shared folder, for shared system configuration (`configuration.nix`), shared Home Manager configuration (`home.nix`), and potentially other shared modules designed for composing modules together in different ways, or otherwise just to keep file lengths down.

Also each host has its own folder, containing a host specific Home Manager configuration (`home.nix`) and if it's not a standalone system a host specific system configuration (`configuration.nix`).

Here's the above as structured in the repo:

```
/
├─ dotfiles/              # actual config files, set up by Home Manager
├─ nixfiles/              # nix files
│  ├─ cloud/                # a Linux host, managed by standalone Home Manager
│  │  ├─ home.nix             # Home Manager configuration
│  ├─ Shadow/               # a macOS host, managed by nix-darwin
│  │  ├─ configuration.nix    # nix-darwin system configuration
│  │  ├─ home.nix             # Home Manager configuration
│  ├─ shared/               # shared modules
│  │  ├─ configuration.nix    # system configuration
│  │  ├─ home.nix             # Home Manager configuration
├─ flake.nix              # root flake definition
```

The relevance of host operating system plays out as follows, then:

- NixOS
  - NixOS hosts will:
    - be added to the root flake under `nixOsConfigurations`
    - have a `configuration.nix`
      - imports `shared/configuration.nix` and possibly other modules
      - sets host specific NixOS config.
    - use Home Manager as a NixOS module
    - have a `home.nix`
      - imports `shared/home.nix` and possibly other modules
      - sets host specific Home Manager config
- macOS (e.g. `Shadow` above)
  - macOS hosts will:
    - be added to the root flake under `darwinConfigurations`
    - have a `configuration.nix`
      - imports `shared/configuration.nix` and possibly other modules
      - sets host specific NixOS config.
    - use Home Manager as a nix-darwin module
    - have a `home.nix`
      - imports `shared/home.nix` and possibly other modules
      - sets host specific Home Manager config
- Other Linux (e.g. `cloud` above)
  - Other Linux hosts will:
    - be added to the root flake under `homeConfigurations`
    - use Home Manager in Standalone mode
    - have a `home.nix`
      - imports `shared/home.nix` and possibly other modules
      - sets host specific Home Manager config
    - _NOT_ have a `configuration.nix`

### Installing

Given the above, installing differs depending on the host operating system and the Nix/Home Manager approach in use.

> [!TIP]
> In the below, `path-to-flake-directory` is to the root of this repo, where `flake.nix` is.
>
> Note that you'll need to specify the flake path each time you run rebuild.

- NixOS
  - run `nix-rebuild switch --flake <path-to-flake-directory>`
  - Home Manager installation will happen as part of system configuration
- macOS (nix-darwin)
  - install Nix (prefer: https://github.com/DeterminateSystems/nix-installer)
  - run `darwin-rebuild switch --flake <path-to-flake-directory>`
  - Home Manager installation will happen as part of system configuration
- Other Linux (Standalone Home Manager)
  - install Nix if necessary
    - prefer: https://github.com/DeterminateSystems/nix-installer
    - Some distros (e.g. Fedora Bazzite) come with it
  - install Home Manager per the [Standalone Flake docs](https://nix-community.github.io/home-manager/index.xhtml#sec-flakes-standalone)
    - bear in mind, we don't need to `init` as we already have a configuration prepared.
    - so for the first run:
      - `nix run home-manager/$branch -- switch --flake <path-to-flake-directory>`
      - `$branch` in this configuration should be at least `release-24.05`, or `master`.
    - subsequent `switch` runs may use the now installed `home-manager` command:
      - `home-manager switch --flake <path-to-flake-directory>`

> [!NOTE]
> It may be worth noting that a flake-based configuration of Home Manager in a non-default location (e.g. where this repo is checked out) requires passing the path of `home.nix` when using `home-manager edit` (e.g. `home-manager edit -f <path-to-home.nix>`).
>
> Given this, and the structure of the nixfiles in this repo, using `home-manager edit` is not recommended over simply opening the repo/files in an editor directly.

## What's not managed here?

As I'm adopting this gradually, primarily on non-NixOS hosts, some key things are provided elsewise by the system.

### Things I would do as System Packages if I could

- Docker / Podman?
- a shiny terminal such as alacritty or kitty
- web browser?

### Things Fedora Bazzite layers via rpm-ostree

- Podman

### macOS oddities?

- None so far, given the above exceptions...

### Things standalone Home Manager doesn't like

- some graphical apps e.g. kitty, alacritty...

## Old dotfiles

My previous setup which _did_ just use scripts to put stuff in place across windows, linux and macos (to different extents) is still available on the `legacy` branch.
