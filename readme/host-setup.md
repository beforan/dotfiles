# Host Setup

This documentation describes how to setup a Host system to use its dotfile configuration from this repository.

This includes:

1. [Host Types](#host-types)
1. [Prerequisites](#prerequisites)
1. [Setup](#setup) for each Host Type
    1. How to get the prerequisites
    1. How to apply your prepared Host Configuration

There is separate guidance available for:

- [Preparing Host Configuration files](configuration-files.md)
- [Managing Hosts outside of Nix Home Manager](no-home-manager.md)
  - [Nix System Packages](sources/host-nix.md) (where applicable)
  - [Flatpak](sources/flatpak.md) (on Linux)
  - [Homebrew](sources/brew.md)
  - [Natively](sources/host-native.md)

## Host Types

Per the [Readme](../README.md), the Host's Operating Systems affects the way [Nix Home Manager] is set up:

| OS | Home Manager | Notes |
|-|-|-|
| [NixOS][Nix] | NixOS Module | The NixOS Linux distribution, running **Home Manager** as a NixOS module |
| macOS | [`nix-darwin`][nix-darwin] Module | Apple Mac managed by **`nix-darwin`** with **Home Manager** running as a module |
| Other Linux | Standalone | Any Linux distribution, with **Home Manager** installed and configured by Nix |

The basic pre-requisites remain the same, and we will cover how to setup each type from this guide.

[Nix Home Manager]: https://nix-community.github.io/home-manager/
[Nix]: https://nixos.org/
[nix-darwin]: https://github.com/LnL7/nix-darwin/

## Prerequisites

All Hosts must have at minimum:

- Nix
  - Flakes enabled
  - Home Manager installed
- Git
  - Flakes require it to work
  - and how else would you get the `dotfiles` repo?
- Host Configuration files

## Setup

Here are the setup guides for each Host Type:

- [NixOS](setup/nixos.md)
- [macOS (`nix-darwin`)](setup/nix-darwin.md)
- [Standalone Home Manager](setup/standalone.md)

### Things to bear in mind

> [!TIP]
> When referred to, `path-to-flake-directory` is to the root of this repo, where `flake.nix` is.
>
> Note that you'll need to specify the flake path each time you run rebuild or switch.


> [!NOTE]
> It may be worth noting that a flake-based configuration of Home Manager in a non-default location (e.g. where this repo is checked out) requires passing the path of `home.nix` when using `home-manager edit` (e.g. `home-manager edit -f <path-to-home.nix>`).
>
> Given this, and the structure of the nixfiles in this repo, using `home-manager edit` is not recommended over simply opening the repo/files in an editor directly.
