# dotfiles

These are my dotfiles.

Rather than scripts to put things in place and symlink, my prevailing approach now is to use [Nix Home Manager] to do as much as possible declaratively.

- To learn about the approach, and when (and when not) to use **Home Manager**, keep reading.
- Dive into how to [setup a Host](readme/host-setup.md).
- Read Guidance on Configuration Files and the structure used in this repo.

## General Approach

The idea is to use **Nix Home Manager** to manage as much as possible, as that's the most portable between different Hosts.

Ideally we automate the installation and configuration of as much as we can, and make differents Hosts as similar as possible.

**Nix Home Manager**:

- takes care of installing user packages/apps as specified in `home.nix`.
- takes care of dotfile configuration by:
  - configuring programs and services directly
  - applying configuration from files in this repo (in `/dotfiles`)
  - symlinking configuration from files in this repo (just like the old scripts did, but from one central standardised location) (in `/dotfiles`)

### Host Operating Systems

With this [general approach](#general-approach) in mind, the way that you use **Nix Home Manager** depends on the Host machine's Operating System.

| OS | Home Manager | Notes |
|-|-|-|
| [NixOS][Nix] | NixOS Module | The NixOS Linux distribution, running **Home Manager** as a NixOS module |
| macOS | [`nix-darwin`][nix-darwin] Module | Apple Mac managed by **`nix-darwin`** with **Home Manager** running as a module |
| Other Linux | Standalone | Any Linux distribution, with **Home Manager** installed and configured by Nix |

In a standalone configuration, **Home Manager** is used to declaratively manage the Host system's User Environments. Since [Nix] is installed, it can also be used for Development Environments, but that's outside of the scope of this documentation.

In **NixOS** and **`nix-darwin`** environments, in addition to the above, the Host's system configuration can also be managed declaratively using **Nix**.

### When not to use **Home Manager**?

Above we state that we use **Home Manager** as much as possible. But when is it not possible, or not advisable?

What do we instead in those cases?

> [!NOTE]
> Here are some suggestions:
> 
> - [Flatpak](readme/sources/flatpak.md)
> - [Homebrew](readme/sources/brew.md)
> - [Nix System Packages](readme/sources/host-nix.md)
> - [Host Native Sources](readme/sources/host-native.md)

A thorough breakdown of options is available [here](readme/no-home-manager.md).

Bear in mind that what alternative options are available will depend somewhat on the [Host Operating System](#host-operating-systems).

## Old dotfiles

My previous setup which _did_ just use scripts to put stuff in place across windows, linux and macos (to different extents) is still available on the `legacy` branch.

[Nix Home Manager]: https://nix-community.github.io/home-manager/
[Nix]: https://nixos.org/
[nix-darwin]: https://github.com/LnL7/nix-darwin/
