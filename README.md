# dotfiles

These are my dotfiles.

Some of them aren't proper dotfiles but are otherwise settings files I want to keep centrally.

Rather than scripts to put things in place and symlink, my prevailing approach now is to use Nix to do as much as possible declaratively.

For now the focus is standalone Nix on linux.

In time, macOS stuff will be here too, and perhaps NixOS eventually.

More docs to follow as stuff takes shape.

## Nix

- Have Nix; everything else here relies on it.
- Enable flakes.
- Distros like Bazzite will preconfigure all this
- Typically if installing Nix yourself, use https://github.com/DeterminateSystems/nix-installer which also enables Flakes by default.

### Home Manager

Actually, since everything here currently is for Nix on non-NixOS Linux, we pretty much do everything in Home Manager.

Nix Home Manager:
- takes care of installing user packages/apps as specified in `home.nix`.
- takes care of dotfile configuration by:
    - configuring programs and services directly
    - applying configuration from files in this repo
    - symlinking configuration from files in this repo (just like the old scripts did, but from one central standardised location)

#### Installing

Installing home manager is easy with flakes enabled, per the docs here: https://nix-community.github.io/home-manager/index.xhtml#sec-flakes-standalone

Using a dotfiles repo (or any non-standard location) as the source of config is slightly more annoying:

```bash
# standard install (creates new config at default location `~/.config/home-manager`)
nix run home-manager/$branch -- init --switch

# specify a specific flake directory to activate
nix run home-manager/$branch -- switch --flake ~/src/.dotfiles
```

The above activation is straightforward; the annoyance is that now:
- Future `home-manager switch` invocations still need you to specify the flake directory:
    - `home-manager switch --flake ~/src/.dotfiles`
- Future `home-manager edit` invocations need you to specify the file to edit:
    - `home-manager edit -f ~/src/.dotfiles/home.nix`

##### Workarounds

- Aliases/functions for the above commands to always specify the extra arguments
- symlinks:
    - `home.nix` to the standard location `~/.config/home-manager/home.nix`
    - `flake.nix` to the standard location `~/.config/home-manager/flake.nix`
    - TODO: could we do this symlinking *IN HOME MANAGER* so that on the first run it does it for us?

## Old dotfiles

My previous setup which *did* use scripts to put stuff in place across windows, linux and macos, to different extents, is still available on the `legacy` branch.
