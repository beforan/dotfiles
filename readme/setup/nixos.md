# NixOS Host Setup

For NixOS, once you have installed NixOS itself, you start with the Host Configuration files, and they take care of everything else.

1. Install NixOS
1. Update / load Configuration Files

## Install NixOS / Initial Configuration Files

Follow the NixOS installation instructions to get your `hardware-configuration.nix` and initial `configuration.nix`.

Don't worry: you can start with the most basic functional `configuration.nix` and iterate on it.

Once you have a `configuration.nix` make sure it includes the following:

```nix
networking.hostName = ""; # Define your hostname.

# enable flakes
nix.settings.experimental-features = ["nix-command" "flakes"];

environment.systemPackages = with pkgs; [
  git
];
```

## Update / Load Configuration Files

With the initial configuration above, you can pull the dotfiles repo and load your actual prepared Host Configuration Files.

This will install Home Manager and apply all your other configuration.

Anytime you want to load updated configuration, run the command again:

```bash
nix-rebuild switch --flake <path-to-flake-directory>
```

`TODO: Actual Shared NixOS specific configuration.nix module`
