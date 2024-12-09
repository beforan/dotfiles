# macOS Host Setup (`nix-darwin`)

1. Install git
1. Install Nix
1. Don't forget to enable flakes!
1. Prepare and load configuration files

## Installing Git

Since we'll install (and configure!) git via Nix as well, you just need whatever Apple will give you to get started.

You can install Git [any way you like](https://macpaw.com/how-to/install-git-mac) but the easiest is probably just `xcode-select --install` in the terminal.

This will install the **XCode Command Line Tools** (🤮), which include Git.

Note that Homebrew also requires these tools, so it's kinda killing two birds with one stone.

## Installing Nix

You can install Nix any way you like.

The [Determinate Nix Installer](https://github.com/DeterminateSystems/nix-installer) is recommended.

Note that for use with `nix-darwin` the `--determinate` flag should NOT be used. The README does explain this, but just to be clear.

## Enabling Flakes

If you used the Determinate Installer above, flakes are enabled.

Otherwise search to discover how to enable flakes for your Nix installation.

## Configuration Files

Refer to Configuration File guidance to prepare your Host configuration.

At this point, the root `flake.nix` has enough configuration to setup both `nix-darwin` and Home Manager using your prepared configuration.

Activate it as follows:

- run `darwin-rebuild switch --flake <path-to-flake-directory>`
  - Home Manager installation will happen as part of system configuration


## Other recommendations

- [Install Homebrew](https://docs.brew.sh/Installation), for anything you [might want it for](sources/brew.md)

`TODO: Actual Shared nix-darwin specific configuration.nix module`
