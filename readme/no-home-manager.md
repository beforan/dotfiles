# When *not* to use **Home Manager**

There are cases where **Home Manager** is either not suitable, or not the best choice. The best alternative may depend on the Host system's environment, as well as what it is that you're managing.

If you consider that both configuration and applications can fit into different categories, each category has a rough priority order in terms of the most suitable management approach.

For a TL;DR you can refer to the below examples for what to use each non-**Home Manager** source for, otherwise keep reading for a breakdown by category.

What to install from:
- [Flatpak](sources/flatpak.md)
- [Homebrew](sources/brew.md)
- [Nix System Packages](sources/host-nix.md)
- [Host Native Sources](sources/host-native.md)

## Host System Configuration

This is for Operating System configuration.

1. Host `configuration.nix`
    - This is only an option on **NixOS** and **macOS**
    - This is declarative and reproducible.
1. Version Controlled config files
    - For system configuration in files, it's still appropriate to version control that config somewhere (here?)
    - If it's truly *system* configuration and not *user* configuration, **Home Manager** isn't suitable
    - You'll have to restore the config (or symlink it) yourself
1. Manual Configuration
    - Just write down what you did, I guess?

## Installing and Configuring System Packages

This is for absolutely essential bare minimum (global!) packages.

This is typically done on **NixOS** (which barely puts anything there you didn't ask for) or getting a Host to a bare minimum operating level (e.g. installing standard libraries or gnu utils or whatever). On most Hosts the OS will already come with this sort of stuff.

1. Host `configuration.nix`
    - This is only an option on **NixOS** and **macOS**
    - On these Hosts, if possible aim to install and configure system packages via `configuration.nix`
      - This is declarative and reproducible.
1. Version controlled shell scripts
    - Basically find a sensible way to record the steps taken reproducibly.
    - ideally get a package manager fast and then script that. e.g. (Nix + Home Manager)

## User Environment Configuration

Traditional per-user dotfiles.

1. **Home Manager**

That's it. Use **Home Manager** for this, it's the whole point.

Absolute worst case `home.file` is a declarative take on traditional dotfiles symlinking.

## Installing and Configuring User Tools

This is the bulk of the user stuff.

Fonts, libraries, SDKs, command line tools, (some GUI apps) and all of their config.

1. **Home Manager**
1. [Homebrew]
    - or another alternate User-scoped package manager
      - on Windows this would be Choco / WinGet
    - (**Home Manager** is better when possible because it's declarative!)
1. **Flatpak**
    - or another sandboxed app installation method
      - AppImage
      - Snaps
1. Native Host OS sources
    - App Store / Discover / Software Centre
    - Native package managers e.g. `rpm-ostree`, `apt`, `dnf`
    - direct downloads (installers or extract to `/opt`)

> [!NOTE]
> Remember, even if you don't install it with **Home Manager**, you may still be able to configure it with **Home Manager** managed dotfiles.

## Installing and Configuring User Applications

This is whatever's left. Primarily GUI applications.

It's a bit of a judgement call, as if you want to declaratively manage installed GUI applications, you'll want to use Home Manager if possible.

However often these applications are not suited to delivery via a standard package manager, aren't in the Nix Packages repository, or have other issues (e.g. some OpenGL apps in Standalone Home Manager)

1. **Flatpak**
    - or another sandboxed app installation method
      - AppImage
      - Snaps
1. Native Host OS sources
    - App Store / Discover / Software Centre
    - Native package managers e.g. `rpm-ostree`, `apt`, `dnf`
    - direct downloads (installers or extract to `/opt`)

[Homebrew]: https://brew.sh/
