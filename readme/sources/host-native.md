# Stuff I install natively

Note that this is VERY host dependent.

- Some Hosts may come with stuff pre-installed e.g.
  - Bazzite -> preinstalls Steam, Ptyxis, Brew etc.
  - macOS -> preinstalls git
- Some Hosts may support more or less stuff via Nix
- On all Hosts it *could* be a direct download (installer or `/opt`), otherwise:
  - macOS -> App Store
  - Atomic Fedora -> `rpm-ostree`
  - Fedora -> `dnf` / Discover
  - Ubuntu -> `apt` / snaps

etc.

# System tools

- Docker
  - For Linux, often comes with distros, otherwise install it "the normal way"
  - For NixOS, install via Nix configuration
  - For macOS, install "the normal way"

# Command Line Tools

# GUI Apps

- Browsers:
  - Edge for macOS.
    - For Linux: Flatpak
- VS Code (if not Flatpak, then native)
