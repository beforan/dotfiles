# Standalone Home Manager

When using Standalone Home Manager you need to:

1. Install Git
1. Install Nix
1. Don't forget to enable flakes!
1. Prepare Host Configuration files
1. Install Standalone Home Manager and load the config

## Installing Git

Since we'll install (and configure!) git via Nix as well, you just need whatever you can get to get started.

It's highly likely your Linux distribution comes with a version of git. Check with `git --version`.

If it doesn't, install it the best native way for your distribution, e.g. `sudo apt install git -y`.

## Installing Nix

You can install Nix any way you like.

The [Determinate Nix Installer](https://github.com/DeterminateSystems/nix-installer) is recommended.

## Enabling Flakes

If you used the Determinate Installer above, flakes are enabled.

Otherwise search to discover how to enable flakes for your Nix installation.

## Configuration Files

Refer to Configuration File guidance to prepare your Host configuration.

## Install Standalone Home Manager

Primarily, you want to follow the **Home Manager** documentation for installing Home Manager as Standalone, using Flakes.

However, there are some considerations.

The docs assume you are both installing Home Manager (for the environment managed by the `flake.nix`) AND setting up your configuration for the first time.

In our case, we have already prepared our Home Manager Configuration (This Host's `home.nix`), so bear in the mind the below:

- install Home Manager per the [Standalone Flake docs](https://nix-community.github.io/home-manager/index.xhtml#sec-flakes-standalone)
    - bear in mind, we don't need to `init` as we already have a configuration prepared.
    - so for the first run:
      - `nix run home-manager/$branch -- switch --flake <path-to-flake-directory>`
      - `$branch` in this configuration should be at least `release-24.05`, or `master`.
    - subsequent `switch` runs may use the now installed `home-manager` command:
      - `home-manager switch --flake <path-to-flake-directory>`

