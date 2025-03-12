## Stuff I install via Flatpak / AppImage / Snaps (instead of nix)

In many cases, GUI apps via Flatpak is a preference if they're not core things. AppImage is a secondary though has some disadvantages compared to Flatpak.

Or if they are but aren't nicely done via nixpkgs/home-manager (e.g. nixGL stuff).

Examples:
- Edge (or browsers generally)
- Godot

# Flatpak preference

Some core things are arguably preferred via Flatpak if not provided by other means:
- Ptyxis - if not provided by the distro, Flatpak is the preferred distribution for this

# AppImage preference

Usually only if it's the only way it's distributed (or there's an issue with the flatpak?)

Recommend using a launcher / helper to create desktop entries, manage centralised installation and uninstallation. Something like `Gear Lever` from Flatpak.

# Snaps

Definitely only if it's the only option.

Requires manual `snapd` installation and possible configuration such as:

- Installing the `core` snap
- Configuring "classic mode"

`snapd` is not in Nix packages currently, so host-specific installation is needed (`apt`, `dnf`, `rpm-ostree`?)

# System tools

- Terminal emulators
  - Ptyxis - if not provided by the distro, use Flatpak
  - iTerm2 - install via Nix configuration
  - ...?

# Command Line Tools

# Snap
- microk8s

# GUI Apps

# Flatpak

- Gear Lever
  - AppImage management, that doen't require AppImage installation
- VS Code if necessary
  - prefer home-manager programs
  - else Flatpak
  - else native
- Web Browsers
  - Edge
    - Linux: Flatpak
    - macOS: Native

# AppImage
- Cursor AI - AppImage
  - not on Flatpak, It's on nixpkgs but home-manager doesn't like it currently
